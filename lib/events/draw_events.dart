import '../events/event.dart';

class Drawing<T> extends Event<T> {
  T? _data;
  Drawing();
  @override
  T? getData() {
    return _data;
  }

  @override
  void setData(T? data) {
    _data = data;
  }
}
