class Pair {
  final String _uuid;
  final int _counter;

  Pair(this._uuid, this._counter);

  String uuid() {
    return _uuid;
  }

  int counter() {
    return _counter;
  }
}