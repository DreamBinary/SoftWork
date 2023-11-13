import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/entity/consume.dart';
import 'home_state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();

  Future<List<Map<String, List<ConsumeData>>>?> getRecord(
      {required String start, String? end, bool isMonth = false}) async {
    return null;
  }

  clear() {
    state.start = null;
    state.end = null;
    state.record = null;
    state.isMonth = false;
    state.outM = 0.0;
    state.inM = 0.0;
  }

  Future<double> _getOut(
      {required String start, String? end, bool isMonth = false}) async {
    return 0.0;
  }

  Future<double> _getIn(
      {required String start, String? end, bool isMonth = false}) async {
    return 0.0;
  }

  Future<List<double>> getOutIn(
      {required String start, String? end, bool isMonth = false}) async {
    return Future.wait([
      _getOut(start: start, end: end, isMonth: isMonth),
      _getIn(start: start, end: end, isMonth: isMonth)
    ]);
  }
}
