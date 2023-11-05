import 'package:account/app/modules/app_module/app_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class appBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => appController());
  }
}