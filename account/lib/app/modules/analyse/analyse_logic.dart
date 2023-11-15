import 'package:get/get.dart';

import 'analyse_state.dart';

class AnalyseLogic extends GetxController {
  final AnalyseState state = AnalyseState();

  Future<double> getOut({isLastMonth = false}) async {
    return 0.0;
  }

  Future<double> getIn({isLastMonth = false}) async {
    return 0.0;
  }

  Future<List<double>> getOutIn({isLastMonth = false}) async {
    return Future.wait(
        [getOut(isLastMonth: isLastMonth), getIn(isLastMonth: isLastMonth)]);
  }
}
