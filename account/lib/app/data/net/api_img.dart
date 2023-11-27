import 'dart:async';
import 'dart:typed_data';

import 'package:account/app/data/entity/consume.dart';
import 'package:account/app/data/net/url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import '../../theme/app_string.dart';
import '../../utils/mmkv.dart';
import 'dio.dart';

class ApiImg {
  static Future<List<String>> upImg({required List<String> imgPaths}) async {
    String token = MMKVUtil.getString(AppString.mmToken);
    List<String> list = [];
    var response = await DioUtil().postForm(
        Url.uploadImg,
        {
          "multipartFiles": List.generate(imgPaths.length,
              (index) => MultipartFile.fromFileSync(imgPaths[index])),
        },
        Options(headers: {"token": token}, contentType: "multipart/form-data"));
    if (response?.data["code"] == 200) {
      List<dynamic> data = response?.data["data"]["list"];
      list = List.generate(data.length, (index) => data[index]);
    }
    return list;
  }

  static Future<String?> getModifyUrl({required String fileName}) async {
    String token = MMKVUtil.getString(AppString.mmToken);
    var response = await DioUtil().post(Url.modify,
        query: {"fileName": fileName},
        options: Options(headers: {"token": token}));
    if (response?.data["code"] == 200) {
      return response?.data["data"]["imgUrl"];
    }
    return null;
  }

  static Future<ConsumeData?> getRecognizeResult({required String fileName}) async {
    String token = MMKVUtil.getString(AppString.mmToken);
    var response = await DioUtil().post(Url.recognizeImg,
        query: {"fileName": fileName},
        options: Options(headers: {"token": token}));
    if (response?.data["code"] == 200) {
      var data=  ConsumeData.fromJson(response?.data["data"]["consumption"]);
      print(data);
      return data;
    }
    return null;
  }

  static Future<ConsumeData?> getScreenRecognizeResult({required String fileName}) async {
    String token = MMKVUtil.getString(AppString.mmToken);
    var response = await DioUtil().post(Url.recognizeImg2,
        query: {"fileName": fileName},
        options: Options(headers: {"token": token}));
    if (response?.data["code"] == 200) {
      return ConsumeData.fromJson(response?.data["data"]["consumption"]);
    }
    return null;
  }

  static Future<Uint8List> downImg({required String url}) async {
    String token = MMKVUtil.getString(AppString.mmToken);
    var response = await DioUtil().get(
      url,
      options: Options(headers: {"token": token}),
    );

    return Uint8List.fromList(response?.data.bodyBytes);
  }

}
