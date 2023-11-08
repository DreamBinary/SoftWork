import 'package:account/app/component/my_header/header_logic.dart';
import 'package:get/get.dart';

import 'more_logic.dart';

class MoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MoreLogic());
  }
}
