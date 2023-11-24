import 'package:account/app/component/my_header/header_logic.dart';
import 'package:get/get.dart';

import 'login_logic.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginLogic());
    Get.lazyPut(() => HeaderLogic());
  }
}
