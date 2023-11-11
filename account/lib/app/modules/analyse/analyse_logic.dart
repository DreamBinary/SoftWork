import 'package:account/app/utils/date_util.dart';
import 'package:get/get.dart';

import '../../data/net/api_consume.dart';
import 'analyse_state.dart';

class AnalyseLogic extends GetxController {
  final AnalyseState state = AnalyseState();

  Future<double> getOut({isLastMonth = false}) async {
    String date = isLastMonth
        ? DateUtil.getLastMonthFormattedDate()
        : DateUtil.getNowFormattedDate();
    return (await ApiConsume.getOut(type: "month", date: "$date 00:00:00"))
            ?.abs() ??
        0.0;
  }

  Future<double> getIn({isLastMonth = false}) async {
    String date = isLastMonth
        ? DateUtil.getLastMonthFormattedDate()
        : DateUtil.getNowFormattedDate();

    return (await ApiConsume.getIn(type: "month", date: "$date 00:00:00"))
            ?.abs() ??
        0.0;
  }

  Future<List<double>> getOutIn({isLastMonth = false}) async {
    return Future.wait(
        [getOut(isLastMonth: isLastMonth), getIn(isLastMonth: isLastMonth)]);
  }
}
