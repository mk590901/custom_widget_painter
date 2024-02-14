import 'package:synchronized/synchronized.dart';

class CircularBuffer<T> {
  late List<T?> _buffer;
  int _readIndex = 0;
  int _writeIndex = 0;
  int _size = 0;
  bool _full = false;
  final Lock _lock = Lock();

  CircularBuffer(int capacity) {
    _buffer = List<T?>.filled(capacity, null);
  }

  Future<void> writeAsync(T value) async {
    await _lock.synchronized(() async {
      write(value);
    });
  }

  List<T?> buffer() {
    return _buffer;
  }

  Future<void> writeRowAsync(List<T> list) async {
    await _lock.synchronized(() async {
      for (var element in list) {
        write(element);
      }
    });
  }

  void writeRow(List<T> list) {
    print ('Circular.writeRow->$_writeIndex [${list.length}]');
    for (var element in list) {
      write(element);
    }
  }

  void write(T value) {
    _buffer[_writeIndex] = value;
    _writeIndex = (_writeIndex + 1) % _buffer.length;
    _size++;
    if (_writeIndex == _readIndex) {
      _full = true;
      _readIndex = (_readIndex + 1) % _buffer.length;
      _size = _buffer.length - 1;
      //print('+write.size#->$_size');
    }
  }

  Future<List<T>> readRowAsync(int orderedSize) async {
    return await _lock.synchronized(() async {
      List<T> result = <T>[];
      int cycles = (orderedSize > size()) ? size() : orderedSize;
      for (int i = 0; i < cycles; i++) {
        T? value = read();
        result.add(value!);
      }
      return result;
    });
  }

  Future<T?> readAsync() async {
    return await _lock.synchronized(() async {
      return read();
    });
  }

  T? read() {
    if (!_full && _readIndex == _writeIndex) {
      return null; // Buffer is empty
    }

    T? value = _buffer[_readIndex];
    _buffer[_readIndex] = null; // ??????
    _size--;
    _readIndex = (_readIndex + 1) % _buffer.length;
    _full = false;
    return value;
  }

  List<T> readRow(int orderedSize) {
    List<T> result = <T>[];
    int cycles = (orderedSize > size()) ? size() : orderedSize;
    for (int i = 0; i < cycles; i++) {
      T? value = read();
      result.add(value!);
    }
    return result;
  }

  bool isFull() {
    return _full;
  }

  bool isEmpty() {
    return !_full && _readIndex == _writeIndex;
  }

  int capacity() {
    return _buffer.length;
  }

  int size() {
    return _size;
  }

  T? get(int index) {
    // Access element at a given index
    return _buffer[(_readIndex + index) % _buffer.length];
  }

  T? getDirect(int index) {
    // Access element at a given index
    return _buffer[index];
  }

  String trace() {
    String result = "";
    for (int i = 0; i < capacity(); i++) {
      T? value = _buffer[i];
      String strValue = (value == null) ? '-' : '$value';
      if (i == _readIndex && i == _writeIndex) {
        result += "[($strValue)]";
      }
      else
      if (i == _readIndex) {
        result += "($strValue)";
      }
      else
      if (i == _writeIndex) {
        result += "[$strValue]";
      }
      else {
        result += "{$strValue}";
      }
    }
    return result;
  }

  int writeIndex() {
    return _writeIndex;
  }

}

