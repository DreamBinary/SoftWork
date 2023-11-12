import 'package:get/get.dart';

import 'image_analyse_logic.dart';

class ImageAnalyseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ImageAnalyseLogic());
  }
}
