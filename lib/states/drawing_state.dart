//import '../obtainer.dart';

import '../pair_data_object.dart';

enum DrawingStates { drawing }

int state_(DrawingStates state) {
  return state.index;
}

class DrawingState {
  final DrawingStates _state;
  late Pair _pair = Pair("", 0);

  DrawingState(this._state) {
    //print ("DrawingState.constructor ($_state)");
    _pair = Pair("", 0);
  }

  DrawingStates state() {
    return _state;
  }
  
  void setData(final Pair pair) {
    _pair = pair;
  }

  int counter() {
    return _pair.counter();
  }

  String uuid() {
    return _pair.uuid();
  }

}
