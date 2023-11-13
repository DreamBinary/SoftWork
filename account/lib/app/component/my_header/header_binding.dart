import 'package:get/get.dart';

import 'header_logic.dart';

class HeaderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HeaderLogic());
  }
}
