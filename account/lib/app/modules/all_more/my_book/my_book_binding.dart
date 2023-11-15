import 'package:get/get.dart';

import '../../../component/my_header/header_logic.dart';
import 'my_book_logic.dart';

class MyBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyBookLogic());
    Get.lazyPut(() => HeaderLogic(), fenix: true);
  }
}
