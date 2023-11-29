import 'package:account/app/data/entity/Goal.dart';
import 'package:account/app/utils/date_util.dart';
import 'package:dio/dio.dart';

import '../../theme/app_string.dart';
import '../../utils/mmkv.dart';
import 'dio.dart';
import 'url.dart';

class ApiGoal {
  // getGoal
  static Future<List<Goal>> getGoal() async {
    String token = MMKVUtil.getString(AppString.mmToken);
    var response = await DioUtil()
        .get(Url.goal, options: Options(headers: {"token": token}));
    List<Goal> list = [];
    if (response?.data["base"]["code"] == 0) {
      response?.data["data"]["list"].forEach((v) {
        list.add(Goal.fromJson(v));
      });
    }
    return list;
  }

  static Future<bool> addGoal(String goalName, num money, DateTime date) async {
    String token = MMKVUtil.getString(AppString.mmToken);
    var response = await DioUtil().post(Url.goal,
        data: {
          "money": money,
          "deadline": DateUtil.getFormattedDateTime(date),
          "goal_name": goalName,
          "create_date": DateUtil.getFormattedDateTime(DateTime.now()),
        },
        options: Options(
            headers: {"token": token}, contentType: "application/json"));
    if (response?.data["code"] == 0) {
      return true;
    }
    return false;
  }

  // deleteGoal
  static Future<bool> deleteGoal(Goal goal) async {
    String token = MMKVUtil.getString(AppString.mmToken);
    var response = await DioUtil().delete(
      Url.goal,
      map: {"goalId": goal.goalId},
      options: Options(
        headers: {"token": token},
        contentType: "application/json",
      ),
    );
    if (response?.data["code"] == 0) {
      return true;
    }
    return false;
  }

  // updateGoal
  static Future<bool> updateGoal(Goal goal) async {
    String token = MMKVUtil.getString(AppString.mmToken);
    var response = await DioUtil().put(
      Url.goal,
      map: goal.toJson(),
      options: Options(
        headers: {"token": token},
        contentType: "application/json",
      ),
    );
    if (response?.data["code"] == 0) {
      return true;
    }
    return false;
  }
}
