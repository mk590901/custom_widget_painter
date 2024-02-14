import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'drawing_bloc.dart';
import 'interfaces/i_counter_updater.dart';
import 'obtainer.dart';
import 'path_painter.dart';
import 'states/drawing_state.dart';
import 'store_wrapper.dart';
import 'package:uuid/uuid.dart';

class CustomWidget extends StatelessWidget implements ICounterUpdater {

  final double width;
  final double height;

  late  int currentCounter = 0;

  final String uuid = const Uuid().v4().toString();

  bool _startStop = false;

  final StoreWrapper storeWrapper = StoreWrapper(200, 5, 6);

  CustomWidget({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {

    final Obtainer
    obtain = Obtainer(const Duration(milliseconds: 24),
        storeWrapper.drawingFrequency(), context, this);

    return Listener(
      onPointerDown: (e) {
        // Handle pointer down event
        _startStop = !_startStop;
        if (_startStop) {
          //print ("_obtainer.start()");
          obtain.start(uuid);
        }
        else {
          //print ("_obtainer.stop()");
          obtain.stop(uuid);
        }

        //@print('onPointerDown');

      },
      onPointerMove: (e) {
        //print('onPointerMove');
      },
      onPointerUp: (e) {
        //print('onPointerUp');
      },
      onPointerCancel: (e) {
        //print('onPointerCancel');
      },

      child: BlocBuilder<DrawingBloc, DrawingState>(builder: (context, state) {

        bool fit = (uuid == state.uuid()) ? true : false;
        if (fit) {
          currentCounter = state.counter();
        }
        storeWrapper.updateBuffer(currentCounter, fit);
        return SizedBox(
          width: width,
          height: height,
          child: CustomPaint(
            painter: PathPainter.graph(currentCounter, storeWrapper),
          ),
        );
      }),
    );
  }

  @override
  void updateCounter(final int counter) {
    currentCounter = counter;
    //print ("******* updateCounter -> [$currentCounter]");
  }
}
