import 'package:get/get.dart';

import 'budget_logic.dart';

class BudgetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BudgetLogic());
  }
}
