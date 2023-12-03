import 'package:get/get.dart';

import '../../data/entity/consume.dart';
import '../../data/net/api_consume.dart';
import 'table_analyse_state.dart';

class TableAnalyseLogic extends GetxController {
  final TableAnalyseState state = TableAnalyseState();

  Future<List<ConsumeData>> getRecord(String date) async {
    if (state.date == null) {
      state.date = date;
      List<Map<String, List<ConsumeData>>> record =
          await ApiConsume.getRecordMap(date: "$date 00:00:00");

      for (var element in record) {
        element.forEach((key, value) {
          state.record.addAll(value);
        });
      }
      print(state.record);
      // state.record =
      // await ApiConsume.getRecord(type: "month", date: "$date 00:00:00");
    }
    return state.record;
  }

  Future<void> clear() async {
    state.date = null;
    state.record.clear();
  }
}
