import 'package:account/app/data/net/url.dart';
import 'package:dio/dio.dart';

import '../../theme/app_string.dart';
import '../../utils/mmkv.dart';
import 'dio.dart';

class ApiGuardian {
  static Future<String?> getCode() async {
    String token = MMKVUtil.getString(AppString.mmToken);
    var response = await DioUtil()
        .get(Url.code, options: Options(headers: {"token": token}));
    if (response?.data["code"] == 200) {
      return response?.data["data"]["code"];
    }
    return null;
  }
}
