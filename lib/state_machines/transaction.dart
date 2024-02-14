import '../interfaces/i_transition_method.dart';

class Transaction {
  final int _state;
  ITransitionMethod? _method;

  Transaction.short(this._state);
  Transaction (this._state, this._method);

  int state() {
    return _state;
  }

  ITransitionMethod? method() {
    return _method;
  }

}