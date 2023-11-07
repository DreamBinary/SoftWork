import 'package:account/app/component/my_header/header_logic.dart';
import 'package:account/app/modules/home/home_view.dart';
import 'package:get/get.dart';

import 'home_logic.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeLogic());
    Get.lazyPut(() => HeaderLogic(), fenix: true);
  }
}
