# Stateless widget for visualization ECG wave

The project implements a widget for dynamic visualization of constantly incoming ECG data. Widget implements a specific visualization method, which consists in the fact that a newly received piece of data is superimposed on a previously drawn wave.

## Introduction

The number of components for graphical data visualization is relatively small. Especially on flutter. Most of them are in the nature of some standard set of widgets with a lot of options and settings. In essence, they are cloned components of charts built into products like Microsoft Excell or Google Sheets. It is more difficult to find widgets for displaying large amounts of data that are continuously received, for example, from measuring instruments. I decided to create my own widget for this, which is based on a very simple principle.

## Visualization algorithm

Typically, any SDK supplied with a wearable ECG device allows you to obtain a data vector of a certain length at a certain frequency. For example 128, 200, 256, 512... & etc. values per second. The task of visualization is to draw this data in the next second. Typically the frequency of the timer that calls the rendering function is calculated. For example, if you need to draw 200 points, then the timer frequency: 1000/200=5ms. 500 values will require 1000/500=2ms to render the frame. And this despite the fact that the human eye is not able to evaluate for the better a frequency greater than 24 frames per second. Existing film standards: https://en.wikipedia.org/wiki/Frame_rate.
All this means that it is more logical to leave the frequency unchanged, for example 25 fps, and calculate the number of new points that need to be drawn in the frame per second. 200/25 gives 8 points, 500/25 - 20.
It is this principle that was used in widget.

## Data structure

It's clear that a data container into which new elements for drawing are constantly being added must be organized in such a way as to minimize the number of shifts in it when adding. For the case of overlaying new images on old ones, a circular (round) buffer is ideal. There are no shifts inside circular buffer needed at all.

## Widget type

## Conclusions

## Movie



https://github.com/mk590901/custom_widget_painter/assets/125393245/b82af22e-c8ec-48ef-a709-bae8358c2756

