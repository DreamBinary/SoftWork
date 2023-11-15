import 'package:account/app/modules/analyse/analyse_logic.dart';
import 'package:account/app/modules/home/home_logic.dart';
import 'package:get/get.dart';

import '../../component/my_header/header_logic.dart';
import '../all_more/more/more_logic.dart';
import 'route_logic.dart';

class RouteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RouteLogic());
    Get.lazyPut(() => HomeLogic());
    Get.lazyPut(() => AnalyseLogic());
    Get.lazyPut(() => MoreLogic());
    Get.lazyPut(() => HeaderLogic(), fenix: true);

  }
}
