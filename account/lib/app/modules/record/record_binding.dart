import 'package:get/get.dart';

import 'record_logic.dart';

class RecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecordLogic());
  }
}
