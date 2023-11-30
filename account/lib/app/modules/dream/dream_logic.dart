import 'dart:math';

import 'package:account/app/data/net/api_goal.dart';
import 'package:account/app/utils/date_util.dart';
import 'package:get/get.dart';

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
      return min(100 - (goal.savedMoney / goal.money * 100).floor(), 100);
    }
    return 0;
  }

  double getSavedPercent() {
    final goal = state.goal;
    if (goal != null) {
      return (goal.savedMoney / goal.money * 100);
    }
    return 0;
  }

  saveMoney(int money) async {
    state.goal?.savedMoney += money;
    final goal = state.goal;
    if (goal != null) {
      await ApiGoal.updateGoal(goal);
    }
  }
}
