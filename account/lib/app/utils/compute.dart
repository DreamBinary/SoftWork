import 'dart:math' as math;

class MathUtil {
  /// 返回数组中的最大值
  static T max<T extends num>(List<T> list) {
    T maxVal = list.reduce((v, e) => math.max(v, e));
    return maxVal;
  }

  static T min<T extends num>(List<T> list) {
    T maxVal = list.reduce((v, e) => math.min(v, e));
    return maxVal;
  }
}
