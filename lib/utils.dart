import 'dart:math';
import 'circular_buffer.dart';

List<int> extractData(final List<int> rowData, final int number) {
  if (rowData.isEmpty) {
    return <int>[];
  }
  if (rowData.length <= number) {
    List<int> result = [...rowData];
    return result;
  }
  List<int> result = rowData.sublist(0, number);
  return result;
}

List<int> extractRangeData(final List<int> rowData, final int start, final int number) {
  List<int> result = <int>[];

  if (rowData.isEmpty) {
    return result;
  }

  if (start < 0) {
    return result;
  }

  if (number <= 0) {
    return result;
  }

  int rowLength = rowData.length;

  if (start >= rowLength) {
    return result;
  }

  if (rowData.length <= start + number) {
    result = rowData.sublist(start, rowLength);
    return result;
  }
  result = rowData.sublist(start, start + number);
  return result;
}

List<int> extractRandData(final List<int> rowData, final int number) {
  if (rowData.isEmpty) {
    return <int>[];
  }
  if (rowData.length <= number) {
    List<int> result = [...rowData];
    return result;
  }

  int finalNumber = rowData.length - number;
  int startNumber = Random().nextInt(finalNumber + 1);

  //@print('startNumber->$startNumber');

  List<int> result = rowData.sublist(startNumber, startNumber + number);

  return result;
}

List<int> generateData(final int number, final int value) {
  List<int> result = List<int>.filled(number, value);
  return result;
}

double getMin(List<int> rowData, int rowSize) {
  int min = rowData[0];
  for (int i = 1; i < rowSize; i++) {
    if (rowData[i] < min) {
      min = rowData[i];
    }
  }
  return min.toDouble();
}

double getMax(List<int> rowData, int rowSize) {
  int max = rowData[0];
  for (int i = 1; i < rowSize; i++) {
    if (rowData[i] > max) {
      max = rowData[i];
    }
  }
  return max.toDouble();
}

double getMinB(final CircularBuffer<int> buffer) {
  List<int?> rowData = buffer.buffer();
  int? min = rowData[0];
  int minV = (min == null) ? 0 : min;
  for (int i = 1; i < buffer.capacity(); i++) {
    int? value = rowData[i];
    int valueV = (value == null) ? 0 : value;
    if (valueV < minV) {
      minV = valueV;
    }
  }
  return minV.toDouble();
}

double getMaxB(final CircularBuffer<int> buffer) {
  List<int?> rowData = buffer.buffer();
  int? max = rowData[0];
  int maxV = (max == null) ? 0 : max;
  for (int i = 1; i < buffer.capacity(); i++) {
    int? value = rowData[i];
    int valueV = (value == null) ? 0 : value;
    if (valueV > maxV) {
      maxV = valueV;
    }
  }
  return maxV.toDouble();
}

int getMinForFullBuffer(final CircularBuffer<int> buffer) {
  int result = 0;
  List<int?> rowData = buffer.buffer();
  if (rowData[0] == null) {
    result = rowData[1]!;
  }
  else {
    result = rowData[0]!;
  }
  return result;
}

double getMinB2(final CircularBuffer<int> buffer) {
  int minV = 0;
  List<int?> rowData = buffer.buffer();
  if (buffer.size() == buffer.capacity()-1) {
    minV = getMinForFullBuffer(buffer);
    for (int i = 1; i < buffer.capacity(); i++) {
      int? value = rowData[i];
      if (value != null) {
        if (value < minV) {
          minV = value;
        }
      }
    }
  }
  else {
    minV = rowData[0]!;
    for (int i = 1; i < buffer.size(); i++) {
      if (rowData[i]! < minV) {
        minV = rowData[i]!;
      }
    }
  }
  return minV.toDouble();
}

double getMaxB2(final CircularBuffer<int> buffer) {
  int maxV = 0;
  List<int?> rowData = buffer.buffer();
  if (buffer.size() == buffer.capacity()-1) {
    maxV = getMinForFullBuffer(buffer);
    for (int i = 1; i < buffer.capacity(); i++) {
      int? value = rowData[i];
      if (value != null) {
        if (value > maxV) {
          maxV = value;
        }
      }
    }
  }
  else {
    maxV = rowData[0]!;
    for (int i = 1; i < buffer.size(); i++) {
      if (rowData[i]! > maxV) {
        maxV = rowData[i]!;
      }
    }
  }
  return maxV.toDouble();
}

List<int> dataSeries(CircularBuffer<int> buffer) {
  int seriesSize =
    buffer.size() < buffer.capacity() - 1 ? buffer.size() : buffer.capacity();
  List<int> result = List<int>.filled(seriesSize, 0);
  for (int i = 0; i < seriesSize; i++) {
    int? value = buffer.getDirect(i); //  getPure()
    if (value != null) {
      result[i] = value;
    } else {
      result[i] = result[i - 1];
    }
  }
  return result;
}
