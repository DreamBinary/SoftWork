import 'package:get/get.dart';

import '../../data/entity/consume.dart';
import '../../data/net/api_consume.dart';
import 'home_state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();

  Future<List<Map<String, List<ConsumeData>>>> getRecord(
      {required String start, String? end, bool isMonth = false}) async {
    if (isMonth) {
      // if (state.start == null ||
      //     state.start != start ||
      //     state.isMonth != isMonth) {
      state.start = start;
      state.isMonth = isMonth;
      state.record = await ApiConsume.getRecordMap(
          date: "${start.split(" ")[0]}-01 00:00:00");
      // }
    } else {
      // if (state.start == null ||
      //     state.start != start ||
      //     state.end != end ||
      //     state.isMonth != isMonth) {
      state.start = start;
      state.isMonth = isMonth;
      state.record = await ApiConsume.getRangeRecordMap(
          start: "${start.split(" ")[0]} 00:00:00",
          end: "${end?.split(" ")[0]} 23:59:59");
    }
    // }
    return state.record!;
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
    if (isMonth) {
      // if (state.start == null ||
      //     state.start != start ||
      //     state.isMonth != isMonth) {
      state.start = start;
      state.isMonth = isMonth;
      state.outM = (await ApiConsume.getOut(
                  type: "month", date: "${start.split(" ")[0]}-01 00:00:00"))
              ?.abs() ??
          0.0;
      // }
    } else {
      // if (state.start == null ||
      //     state.start != start ||
      //     state.end != end ||
      //     state.isMonth != isMonth) {
      state.start = start;
      state.isMonth = isMonth;
      state.outM = (await ApiConsume.getRangeOut(
                  start: "${start.split(" ")[0]} 00:00:00",
                  end: "${end?.split(" ")[0]} 23:59:59"))
              ?.abs() ??
          0.0;
      // }
    }
    return state.outM;
  }

  Future<double> _getIn(
      {required String start, String? end, bool isMonth = false}) async {
    if (isMonth) {
      // if (state.start == null ||
      //     state.start != start ||
      //     state.isMonth != isMonth) {
      state.start = start;
      state.isMonth = isMonth;
      state.inM = (await ApiConsume.getIn(
                  type: "month", date: "${start.split(" ")[0]}-01 00:00:00"))
              ?.abs() ??
          0.0;
      // }
    } else {
      // if (state.start == null ||
      //     state.start != start ||
      //     state.end != end ||
      //     state.isMonth != isMonth) {
      state.start = start;
      state.isMonth = isMonth;
      var inM = await ApiConsume.getRangeIn(
          start: "${start.split(" ")[0]} 00:00:00",
          end: "${end?.split(" ")[0]} 23:59:59");
      state.inM = inM?.abs() ?? 0.0;
      print(state.inM);
    }
    // }
    print("getIn");
    print(state.inM);
    return state.inM;
  }

  Future<List<double>> getOutIn(
      {required String start, String? end, bool isMonth = false}) async {
    var out = await _getOut(start: start, end: end, isMonth: isMonth);
    var inM = await _getIn(start: start, end: end, isMonth: isMonth);
    return [out, inM];
    return Future.wait([
      _getIn(start: start, end: end, isMonth: isMonth),
      _getOut(start: start, end: end, isMonth: isMonth),
    ]);
  }
}
