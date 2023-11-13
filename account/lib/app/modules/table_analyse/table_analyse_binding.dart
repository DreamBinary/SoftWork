import 'package:get/get.dart';

import 'table_analyse_logic.dart';

class TableAnalyseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TableAnalyseLogic());
  }
}
