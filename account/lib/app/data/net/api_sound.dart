import 'package:account/app/data/net/url.dart';
import 'package:dio/dio.dart';

import '../../theme/app_string.dart';
import '../../utils/mmkv.dart';
import 'dio.dart';

class ApiSound {
  static Future<List<String>> upSound(String path) async {
    String token = MMKVUtil.getString(AppString.mmToken);
    var response = await DioUtil().postForm(
        Url.upSound,
        {
          "speech": MultipartFile.fromFileSync(path),
        },
        Options(headers: {"token": token}, contentType: "multipart/form-data"));
    List<String> words = [];
    if (response?.data["code"] == 200) {
      List<dynamic> temp = response?.data["data"]["words"];
      for (var element in temp) {
        words.add(element);
      }
      // list = List.generate(data.length, (index) => data[index]);
    }
    return words;
  }
}
