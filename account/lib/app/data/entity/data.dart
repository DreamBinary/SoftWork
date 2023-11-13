import '../../utils/compute.dart';

class Data {
  List<double> data;
  late int len = data.length;
  late double maxY = MathUtil.max(data);
  late double minY = MathUtil.min(data);
  final List<int> _minX = [];

  final List<int> _maxX = [];

  get minDays {
    return "${_minX.join(",")}号";
  }

  get maxDays {
    return "${_maxX.join(",")}号";
  }

  Data(this.data) {
    for (var i = 0; i < len; ++i) {
      if (data[i] == minY) {
        _minX.add(i + 1);
      } else if (data[i] == maxY) {
        _maxX.add(i + 1);
      }
    }
  }
}
