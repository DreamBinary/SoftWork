import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../theme/app_string.dart';
import '../../utils/mmkv.dart';
import '../entity/consume.dart';
import 'dio.dart';
import 'url.dart';

class ApiConsume {
  static Future<double?> getRemain({required String type, String? date}) async {
    String token = MMKVUtil.getString(AppString.mmToken);
    String url = "";
    if (type == "all") {
      url = Url.allRemain;
      date = null;
    } else if (type == "year") {
      url = Url.yearRemain;
    } else if (type == "month") {
      url = Url.monthRemain;
    } else if (type == "day") {
      url = Url.dayRemain;
    } else {
      return null;
    }
    debugPrint("getRemain");
    var response = await DioUtil().get(url,
        map: date == null ? null : {"date": date},
        options: Options(headers: {"token": token}));
    if (response?.data["code"] == 0) {
      return response?.data["data"]["sum"];
    }
    return null;
  }

  static Future<double?> getOut({required String type, String? date}) async {
    String token = MMKVUtil.getString(AppString.mmToken);
    String url = "";
    if (type == "all") {
      url = Url.allOut;
      date = null;
    } else if (type == "year") {
      url = Url.yearOut;
    } else if (type == "month") {
      url = Url.monthOut;
    } else if (type == "day") {
      url = Url.dayOut;
    } else {
      return null;
    }
    var response = await DioUtil().get(url,
        map: date == null ? null : {"date": date},
        options: Options(headers: {"token": token}));
    print(url);
    print("object");
    print(response?.data["data"]);

    if (response?.data["code"] == 0) {
      return response?.data["data"]["sum"];
    }
    return null;
  }

  static Future<double?> getIn({required String type, String? date}) async {
    String token = MMKVUtil.getString(AppString.mmToken);
    String url = "";
    if (type == "all") {
      url = Url.allIn;
      date = null;
    } else if (type == "year") {
      url = Url.yearIn;
    } else if (type == "month") {
      url = Url.monthIn;
    } else if (type == "day") {
      url = Url.dayIn;
    } else {
      return null;
    }
    var response = await DioUtil().get(url,
        map: date == null ? null : {"date": date},
        options: Options(headers: {"token": token}));
    // print("getIn");
    print(response?.data["data"]);
    if (response?.data["code"] == 0) {
      return response?.data["data"]["sum"];
    }

    return null;
  }

  static Future<List<ConsumeData>> getYearRecord(String date) async {
    String token = MMKVUtil.getString(AppString.mmToken);
    var response = await DioUtil().get(Url.yearRecord,
        map: {"date": date}, options: Options(headers: {"token": token}));
    List<ConsumeData> list = [];
    if (response?.data["code"] == 0) {
      for (var item in response?.data["data"]["list"]) {
        list.add(ConsumeData.fromJson(item));
      }
    }
    return list;
  }

  static Future<List<ConsumeData>> getRecord(
      {required String type, String? date}) async {
    String token = MMKVUtil.getString(AppString.mmToken);
    List<ConsumeData> list = [];
    String url = "";
    if (type == "all") {
      url = Url.allRecord;
      date = null;
    } else if (type == "year") {
      url = Url.yearRecord;
    } else if (type == "month") {
      url = Url.monthRecord;
    } else if (type == "day") {
      url = Url.dayRecord;
    } else {
      return list;
    }
    var response = await DioUtil().get(url,
        map: date == null ? null : {"date": date},
        options: Options(headers: {"token": token}));

    if (response?.data["code"] == 0) {
      for (var item in response?.data["data"]["list"]) {
        list.add(ConsumeData.fromJson(item));
      }
    }
    return list;
  }

  static Future<num?> addConsume(ConsumeData cData) async {
    String token = MMKVUtil.getString(AppString.mmToken);
    var response = await DioUtil().post(
      Url.addRecord,
      data: cData.toJson(),
      options:
          Options(headers: {"token": token}, contentType: "application/json"),
    );
    print("addConsume");
    print(response?.data);
    if (response?.data["code"] == 0) {
      num id = response?.data["consumption_id"];
      return id;
    }
    return null;
  }

  static Future<List<Map<String, List<ConsumeData>>>> getRecordMap(
      {required String date}) async {
    String token = MMKVUtil.getString(AppString.mmToken);
    List<Map<String, List<ConsumeData>>> list = [];
    String url = Url.recordMap;

    var response = await DioUtil().get(url,
        map: {"date": date}, options: Options(headers: {"token": token}));
    if (response?.data["code"] == 0) {
      var keys = response?.data["data"].keys.toList();
      List<dynamic> values = response?.data["data"].values.toList();
      int len = keys.length;
      for (int i = 0; i < len; ++i) {
        List<ConsumeData> cData = [];
        if (values[i].runtimeType != List) {
          continue;
        }
        for (var e in values[i]) {
          cData.add(ConsumeData.fromJson(e));
        }

        list.add({keys[i]: cData});
      }
    }
    print(list);
    return list;
  }

  static Future<List<Map<String, List<ConsumeData>>>> getRangeRecordMap(
      {required String start, required String end}) async {
    String token = MMKVUtil.getString(AppString.mmToken);
    List<Map<String, List<ConsumeData>>> list = [];
    String url = Url.rangeRecordMap;

    var response = await DioUtil().get(url,
        map: {"start": start, "end": end},
        options: Options(headers: {"token": token}));
    print("getRangeRecordMap");
    if (response?.data["code"] == 0) {
      var keys = response?.data["data"].keys.toList();
      print(keys);
      List<dynamic> values = response?.data["data"].values.toList();
      int len = keys.length;
      for (int i = 0; i < len; ++i) {
        List<ConsumeData> cData = [];
        if (values[i].runtimeType != List) {
          continue;
        }
        for (var e in values[i]) {
          var k = ConsumeData.fromJson(e);
          cData.add(k);
        }
        list.add({keys[i]: cData});
      }
    }
    return list;
  }

  static Future<double?> getRangeOut(
      {required String start, required String end}) async {
    String token = MMKVUtil.getString(AppString.mmToken);
    String url = Url.rangeOut;
    var response = await DioUtil().get(url,
        map: {"start": start, "end": end},
        options: Options(headers: {"token": token}));
    if (response?.data["code"] == 0) {
      var result = double.parse(response!.data["data"]["sum"].toString());
      return result;
    }
    return null;
  }

  static Future<double?> getRangeIn(
      {required String start, required String end}) async {
    String token = MMKVUtil.getString(AppString.mmToken);
    String url = Url.rangeIn;
    var response = await DioUtil().get(url,
        map: {"start": start, "end": end},
        options: Options(headers: {"token": token}));
    print(response);
    if (response?.data["code"] == 0) {
      var result = double.parse(response!.data["data"]["sum"].toString());
      print("getRangeIn");
      print(result);
      return result;
    }
    return null;
  }

// static Future<List<Map<String, double>>> getMonthTypePercent(
//     {required String date}) async {
//   String token = MMKVUtil.getString(AppString.mmToken);
//   List<Map<String, double>> list = [];
//   String url = Url.monthType;
//   print("getMonthTypePercent");
//   var response = await DioUtil().get(url,
//       map: {"date": date}, options: Options(headers: {"token": token}));
//   if (response?.data["code"] == 0) {
//     var keys = response?.data["data"].keys.toList();
//     List<dynamic> values = response?.data["data"].values.toList();
//
//     int len = keys.length;
//     for (int i = 0; i < len; ++i) {
//       double v = values[i];
//       v = v.toPrecision(2);
//       String k = ConsumeData.types[int.parse(keys[i]) - 1];
//
//       list.add({k: v});
//     }
//   }
//   return list;
// }

// static Future<List<double>> getThirtyOutList({required String date}) async {
//   String token = MMKVUtil.getString(AppString.mmToken);
//   List<double> list = [];
//   String url = Url.thirtyOutMoney;
//
//   var response = await DioUtil().get(url,
//       map: {"date": date}, options: Options(headers: {"token": token}));
//   if (response?.data["code"] == 0) {
//     List<dynamic> data = response?.data["data"]["money"].toList();
//     for (double e in data) {
//       list.add(e.abs());
//     }
//   }
//   print(list);
//   return list;
// }
}
