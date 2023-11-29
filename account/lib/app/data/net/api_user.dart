import 'dart:convert';

import 'package:dio/dio.dart';

import '../../theme/app_string.dart';
import '../../utils/mmkv.dart';
import 'dio.dart';
import 'url.dart';

class ApiUser {
  // static Future<bool> sendSms(String phone) async {
  //   var response = await DioUtil().get(Url.sendSms, map: {"mobile": phone});
  //   if (response?.data["code"] == 200) {
  //     return true;
  //   }
  //   return false;
  // }

  static Future<bool> signUp(String phone, String password) async {
    var response = await DioUtil().post(
      Url.signUp,
      query: {
        "username": phone,
        "password": password,
      },
    );
    if (response?.data["code"] == 0) {
      return true;
    }
    return false;
  }

  static Future<bool> login(String username, String password) async {
    var response = await DioUtil().postForm(
        Url.login,
        {"username": username, "password": password},
        Options(contentType: "multipart/form-data"));
    if (response?.data["base"]["code"] == 0) {
      String token = response?.data["token"];
      MMKVUtil.put(AppString.mmToken, token);
      return true;
    }
    return false;
  }

  // static Future<bool> getInfo(String token) async {
  //   var response = await DioUtil()
  //       .get(Url.user, options: Options(headers: {"token": token}));
  //   if (response?.data["code"] == 1) {
  //     MMKVUtil.put(AppString.mmUserData, jsonEncode(response?.data["data"]));
  //     return true;
  //   }
  //   return false;
  // }

  // static Future<bool> changeInfo(
  //     {String? avatarPath, String? nickname, String? passwd}) async {
  //   String token = MMKVUtil.getString(AppString.mmToken);
  //   if (token == "") {
  //     return false;
  //   }
  //   var response = await DioUtil().putForm(
  //       Url.user,
  //       {
  //         "avatar": avatarPath == null
  //             ? null
  //             : MultipartFile.fromFileSync(avatarPath),
  //         "nickname": nickname,
  //         "passwd": passwd
  //       },
  //       options: Options(
  //           headers: {"token": token}, contentType: "multipart/form-data"));
  //   await getInfo(token);
  //   if (response?.data["code"] == 1) {
  //     return true;
  //   }
  //   return false;
  // }

  static logout() async {
    String token = MMKVUtil.getString(AppString.mmToken);
    if (token == "") {
      return false;
    }
    var response = await DioUtil()
        .post(Url.logout, options: Options(headers: {"token": token}));
    if (response?.data["code"] == 1) {
      MMKVUtil.clear();
      return true;
    }
    return false;
  }

  // static deleteUser() async {
  //   String token = MMKVUtil.getString(AppString.mmToken);
  //   if (token == "") {
  //     return false;
  //   }
  //   var response = await DioUtil()
  //       .delete(Url.user, options: Options(headers: {"token": token}));
  //   if (response?.data["code"] == 1) {
  //     MMKVUtil.clear();
  //     return true;
  //   }
  //   return false;
  // }
}
