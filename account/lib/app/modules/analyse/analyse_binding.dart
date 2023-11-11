import 'package:get/get.dart';

import 'analyse_logic.dart';

class AnalyseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AnalyseLogic());
  }
}
