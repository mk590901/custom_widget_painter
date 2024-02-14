import '../events/event.dart';
import '../interfaces/i_transition_method.dart';

class Trans {
  final Event _event;
  final int _state;
  final ITransitionMethod? _method;

  Trans(this._event, this._state, this._method);
  // Trans(this._event, this._state, this._method) {
  //   print ("trans ${_event}(${_event.hashCode}):${_state}:${_method}");
  // }

  Event event() {
    return _event;
  }

  int state() {
    return _state;
  }

  ITransitionMethod? method() {
    return _method;
  }

}