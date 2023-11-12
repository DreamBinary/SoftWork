import 'dart:math';

import 'package:account/app/data/entity/data.dart';
import 'package:account/app/data/net/api_consume.dart';
import 'package:get/get.dart';

import 'image_analyse_state.dart';

class ImageAnalyseLogic extends GetxController {
  final ImageAnalyseState state = ImageAnalyseState();

  Future<Data> getThirtyOutList(String date) async {
    if (state.thirtyOutList == null || state.date != date) {
      state.date = date;
      state.thirtyOutList =
          await ApiConsume.getThirtyOutList(date: "$date 00:00:00");
    }
    return Data(state.thirtyOutList!);
  }

  Future<void> getPercentage(String date) async {
    if (state.percentage == null || state.date != date) {
      state.date = date;
      state.percentage =
          await ApiConsume.getMonthTypePercent(date: "$date 00:00:00");
      state.percentage
          ?.sort((a, b) => a.values.first.compareTo(b.values.first));
    }
  }

  Future<List<Map<String, double>>> getTypeTop4(String date) async {
    await getPercentage(date);
    List<Map<String, double>> list = state.percentage!;
    list = list.sublist(0, list.length > 4 ? 4 : list.length);
    double sum = 0;
    for (var e in list) {
      sum += e.values.first;
    }
    list.add({"其余": max((1 - sum).toPrecision(2), 0)});
    list.sort((a, b) => b.values.first.compareTo(a.values.first));
    return list;
  }

  Future<List<Map<String, double>>> getTypeAll(String date) async {
    await getPercentage(date);
    return state.percentage!;
  }

  Future<void> clear() async {
    state.percentage = null;
    state.date = null;
  }

  Future<double> _getOut({required String date}) async {
    return (await ApiConsume.getOut(type: "month", date: "$date 00:00:00"))
            ?.abs() ??
        0.0;
  }

  Future<double> _getIn({required String date}) async {
    return (await ApiConsume.getIn(type: "month", date: "$date 00:00:00"))
            ?.abs() ??
        0.0;
  }

  Future<List<double>> getOutIn({required String date}) async {
    return Future.wait([
      _getOut(
        date: date,
      ),
      _getIn(date: date)
    ]);
  }
}
