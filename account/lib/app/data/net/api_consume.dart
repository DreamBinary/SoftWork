import 'package:dio/dio.dart';
import 'package:get/get.dart';

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
    var response = await DioUtil().get(url,
        map: date == null ? null : {"date": date},
        options: Options(headers: {"token": token}));
    if (response?.data["code"] == 200) {
      return response?.data["data"]["balance"];
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
    if (response?.data["code"] == 200) {
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
    if (response?.data["code"] == 200) {
      return response?.data["data"]["sum"];
    }
    return null;
  }

  static Future<List<ConsumeData>> getYearRecord(String date) async {
    String token = MMKVUtil.getString(AppString.mmToken);
    var response = await DioUtil().get(Url.yearRecord,
        map: {"date": date}, options: Options(headers: {"token": token}));
    List<ConsumeData> list = [];
    if (response?.data["code"] == 200) {
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

    if (response?.data["code"] == 200) {
      for (var item in response?.data["data"]["list"]) {
        list.add(ConsumeData.fromJson(item));
      }
    }
    return list;
  }

  static Future<bool> addConsume(ConsumeData cData) async {
    String token = MMKVUtil.getString(AppString.mmToken);
    var response = await DioUtil().post(Url.addRecord,
        data: cData.toJson(),
        options: Options(
            headers: {"token": token}, contentType: "application/json"));
    if (response?.data["code"] == 200) {
      return true;
    }
    return false;
  }

  static Future<List<Map<String, List<ConsumeData>>>> getRecordMap(
      {required String date}) async {
    String token = MMKVUtil.getString(AppString.mmToken);
    List<Map<String, List<ConsumeData>>> list = [];
    String url = Url.recordMap;

    var response = await DioUtil().get(url,
        map: {"date": date}, options: Options(headers: {"token": token}));
    if (response?.data["code"] == 200) {
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
    if (response?.data["code"] == 200) {
      var keys = response?.data["data"].keys.toList();
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
    if (response?.data["code"] == 200) {
      return response?.data["data"]["sum"] ?? 0.0;
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
    if (response?.data["code"] == 200) {
      return response?.data["data"]["sum"] ?? 0.0;
    }
    return null;
  }

  static Future<List<Map<String, double>>> getMonthTypePercent(
      {required String date}) async {
    String token = MMKVUtil.getString(AppString.mmToken);
    List<Map<String, double>> list = [];
    String url = Url.monthType;

    var response = await DioUtil().get(url,
        map: {"date": date}, options: Options(headers: {"token": token}));
    if (response?.data["code"] == 200) {
      var keys = response?.data["data"].keys.toList();
      List<dynamic> values = response?.data["data"].values.toList();

      int len = keys.length;
      for (int i = 0; i < len; ++i) {
        double v = values[i];
        v = v.toPrecision(2);
        String k = ConsumeData.types[int.parse(keys[i]) - 1];

        list.add({k: v});
      }
    }
    return list;
  }

  static Future<List<double>> getThirtyOutList({required String date}) async {
    String token = MMKVUtil.getString(AppString.mmToken);
    List<double> list = [];
    String url = Url.thirtyOutMoney;

    var response = await DioUtil().get(url,
        map: {"date": date}, options: Options(headers: {"token": token}));
    if (response?.data["code"] == 200) {
      List<dynamic> data = response?.data["data"]["money"].toList();
      for (double e in data) {
        list.add(e.abs());
      }
    }
    print(list);
    return list;
  }
}
