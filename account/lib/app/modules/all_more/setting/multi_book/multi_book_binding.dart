import 'package:get/get.dart';

import 'multi_book_logic.dart';

class MultiBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MultiBookLogic());
  }
}
