


import 'package:intl/intl.dart';

class DateUtil {
  static String getFormattedDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String getFormattedTime(DateTime date) {
    return DateFormat('hh:mm:ss').format(date);
  }

  static String getFormattedDateTime(DateTime date) {
    return DateFormat('yyyy-MM-dd hh:mm:ss').format(date);
  }


  static String getNowFormattedDate() {
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  static String getLastMonthFormattedDate() {
    var now = DateTime.now();
    var lastMonth = DateTime(now.year, now.month - 1, now.day);
    return DateFormat('yyyy-MM-dd').format(lastMonth);
  }

}