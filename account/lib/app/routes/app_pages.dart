import '../../app/modules/app_module/app_bindings.dart';
import '../../app/modules/app_module/app_page.dart';
import 'package:get/get.dart';
part './app_routes.dart';
/**
 * GetX Generator - fb.com/htngu.99
 * */

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.APP,
      page: () => appPage(),
      binding: appBinding(),
    ),
  ];
}