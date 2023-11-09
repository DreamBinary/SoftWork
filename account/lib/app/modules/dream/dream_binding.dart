import 'package:get/get.dart';

import 'dream_logic.dart';

class DreamBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DreamLogic());
  }
}
