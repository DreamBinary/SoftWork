import 'package:intl/intl.dart';

extension MoneyDouble on double {
  /// double 显示金额格式
  String get moneyFormatZero {
    NumberFormat format = NumberFormat("#,##0.00");
    return format.format(this);
  }


  String get moneyFormat {
    NumberFormat format = NumberFormat("#,##0");
    return format.format(this);
  }
}