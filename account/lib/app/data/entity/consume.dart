import 'dart:math';

import 'package:account/app/utils/date_util.dart';
import 'package:flutter/material.dart';

import '../../../res/assets_res.dart';

class ConsumeData {
  static List<String> types = [
    "交通", // 0
    "办公", // 1
    "日用", // 2
    "服务", // 3
    "数码", // 4
    "房租", // 5
    "通讯", // 6
    "住宿", // 7
    "邮寄", // 8
    "医疗", // 9
    "餐饮", // 10
    "食品", // 11
    "服饰", // 12
    "用车", // 13
    "教育", // 14
    "其他" // 15
  ];

  static List<String> paths = [
    AssetsRes.CLASS_TRANSPORT,
    AssetsRes.CLASS_OFFICE,
    AssetsRes.CLASS_DAILY,
    AssetsRes.CLASS_SERVICE,
    AssetsRes.CLASS_DIGITAL,
    AssetsRes.CLASS_DECORATION,
    AssetsRes.CLASS_COMMUNICATION,
    AssetsRes.CLASS_ACCOMMODATION,
    AssetsRes.CLASS_MAIL,
    AssetsRes.CLASS_MEDICINE,
    AssetsRes.CLASS_CATERING,
    AssetsRes.CLASS_FOOD,
    AssetsRes.CLASS_DECORATION,
    AssetsRes.CLASS_USECAR,
    AssetsRes.CLASS_EDUCATE,
    AssetsRes.CLASS_OTHER,
  ];

  ConsumeData(
      {required this.consumptionName,
      required this.description,
      required this.amount,
      required this.typeId,
      required this.store,
      required this.consumeTime,
      required this.consumeDate,
      required this.credential,
      this.imgUrl});

  ConsumeData.fromJson(dynamic json) {
    credential = json['credential'] ?? "";
    imgUrl = credential.startsWith("http")
        ? credential
        : (credential == "default"
            ? null
            : "http://luke.host/images/$credential");
    consumptionName = json['consumptionName'] ?? "";
    description = json['description'] ?? "";
    amount = json['amount'] ?? 0.0;
    typeId = json['typeId'] == null || json["typeId"] - 1 < 0
        ? 15
        : json['typeId'] - 1;
    store = json['store'];
    List<String> str = (json['consumeTime'] ?? DateUtil.getNowFormattedDate())
        .toString()
        .split(" ");
    consumeTime = str.length > 1 ? str[1] : "00:00:00";
    consumeDate = str[0];
  }

  late String consumptionName;
  late String description;
  late double amount;
  late int typeId;
  late String store;
  late String consumeTime;
  late String consumeDate;
  late String credential;
  String? imgUrl;

  @override
  String toString() {
    return 'ConsumeData{ consumptionName: $consumptionName, description: $description, amount: $amount, type: $typeId, store: $store, consumeTime: $consumeTime, consumeDate: $consumeDate, credential: $credential}';
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['typeId'] = typeId;
    map['description'] = description;
    map['consumeTime'] = "$consumeDate 00:00:00";
    map['credential'] = credential;
    map['store'] = store;
    map['consumptionName'] = consumptionName;
    map['consumptionId'] = 1;
    map['amount'] = amount;
    return map;
  }
}
