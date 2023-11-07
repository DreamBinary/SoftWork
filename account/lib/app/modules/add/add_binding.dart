import 'package:get/get.dart';

import 'add_logic.dart';

class AddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddLogic());
  }
}
