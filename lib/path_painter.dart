import 'dart:math';
import 'package:flutter/material.dart';
import 'store_wrapper.dart';
import 'circular_buffer.dart';

class PathPainter extends CustomPainter {
  int counter;

  final StoreWrapper _storeWrapper;

  late CircularBuffer<int>
    buffer;

  final paintCircle = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.fill;

  static const markerRadius = 6.0;

//  For graph ......................................................

  Paint paint_ = Paint()
    ..color = Colors.blue
    ..strokeWidth = 2.0
    ..style = PaintingStyle.fill;

  Paint paintPrev = Paint()
    ..color = Colors.blueGrey
    ..strokeWidth = 2.0
    ..style = PaintingStyle.fill;

  Paint paintLine = Paint()
    ..color = Colors.white
    ..strokeWidth = 1.0
    ..style = PaintingStyle.stroke;

  Paint paintLineAfter = Paint()
    ..color = Colors.white38
    ..strokeWidth = 1.0
    ..style = PaintingStyle.stroke;

  Paint paintMarker = Paint()
    ..color = Colors.blueGrey //Colors.white12
    ..strokeWidth = 16.0
    ..style = PaintingStyle.stroke;

//  ................................................................

  PathPainter.graph(this.counter, this._storeWrapper) {
    buffer = _storeWrapper.buffer();
    //print('PathPainter.graph.$counter');

  }

  @override
  void paint(Canvas canvas, Size size) {
    drawGraph(size, canvas);
  }

  void drawGraph(Size size, Canvas canvas) {

    // Draw a rectangle
    double shiftH  = size.height/6;

    canvas.drawRect(Rect.fromLTRB(0, 0,
        size.width, size.height), paint_);

    if (counter == 0) {
      return;
    }

    _storeWrapper.prepareDrawing(size, shiftH);

    canvas.drawRect(Rect.fromLTRB(_storeWrapper.point.dx, 0, size.width, size.height), paintPrev);
//    canvas.drawPath(_storeWrapper.path, paintLine);
    canvas.drawPath(_storeWrapper.pathBefore, paintLine);
    canvas.drawPath(_storeWrapper.pathAfter, paintLineAfter);
    canvas.drawCircle(_storeWrapper.point, markerRadius, paintCircle);


    // path = Path();
    // path.moveTo(idx * step + 24, shiftV);
    // path.lineTo(idx * step + 24, shiftV + height);
    // canvas.drawPath(path, paintMarker);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true; // todo - determine if the path has changed
  }


}
