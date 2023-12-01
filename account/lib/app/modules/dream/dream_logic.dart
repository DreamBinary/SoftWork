import 'dart:math';

import 'package:account/app/data/net/api_consume.dart';
import 'package:account/app/data/net/api_goal.dart';
import 'package:account/app/utils/date_util.dart';
import 'package:get/get.dart';

import '../../data/entity/consume.dart';
import 'dream_state.dart';

class DreamLogic extends GetxController {
  final DreamState state = DreamState();

  Future<bool> init() async {
    var list = await ApiGoal.getGoal();
    if (list.isNotEmpty) {
      state.goal = list[0];
      return true;
    }
    return false;
  }

  updateGoal(String goalName, DateTime date, num money) async {
    final goal = state.goal;
    if (goal != null) {
      goal.goalName = goalName;
      goal.deadline = DateUtil.getFormattedDateTime(date);
      goal.money = money;
      ApiGoal.updateGoal(goal);
    }
  }

  deleteGoal() async {
    final goal = state.goal;
    state.goal = null;
    if (goal != null) {
      ApiGoal.deleteGoal(goal);
    }
  }

  addGoal(String goalName, DateTime date, num money) async {
    await ApiGoal.addGoal(goalName, money, date);
    state.goal = (await ApiGoal.getGoal())[0];
  }

  int getGapMoney() {
    final goal = state.goal;
    if (goal != null) {
      return max((goal.money - goal.savedMoney).toInt(), 0);
    }
    return 0;
  }

  int getGapMoneyPercent() {
    final goal = state.goal;
    if (goal != null) {
      return ((1 - getSavedPercent()) * 100).toInt();
    }
    return 0;
  }

  double getSavedPercent() {
    final goal = state.goal;
    if (goal != null) {
      return min(max(goal.savedMoney, 0) / goal.money, 1);
    }
    return 0;
  }

  saveMoney(int money) async {
    state.goal?.savedMoney += money;
    if (state.goal != null) {
      await ApiConsume.addConsume(
        ConsumeData(
          consumptionName: "存钱",
          description: "存钱",
          amount: money,
          typeId: 15,
          store: "存钱",
          consumeTime: DateUtil.getNowFormattedDate(),
          consumeDate: DateUtil.getNowFormattedDate(),
          credential: "",
        ),
      );
    }
  }
}
