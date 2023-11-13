import 'package:get/get.dart';

import '../../data/entity/consume.dart';
import 'table_analyse_state.dart';

class TableAnalyseLogic extends GetxController {
  final TableAnalyseState state = TableAnalyseState();


  Future<void> clear() async {
    state.date = null;
    state.record.clear();
  }
}
