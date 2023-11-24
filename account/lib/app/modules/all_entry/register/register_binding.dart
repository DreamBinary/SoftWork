import 'package:get/get.dart';

import '../login/login_logic.dart';
import 'register_logic.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterLogic());
    Get.lazyPut(() => LoginLogic());
  }
}
