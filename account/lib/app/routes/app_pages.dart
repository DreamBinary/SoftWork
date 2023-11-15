import 'package:account/app/modules/add/add_binding.dart';
import 'package:account/app/modules/add/add_view.dart';
import 'package:account/app/modules/analyse/analyse_binding.dart';
import 'package:account/app/modules/analyse/analyse_view.dart';
import 'package:account/app/modules/dream/dream_view.dart';
import 'package:account/app/modules/home/home_binding.dart';
import 'package:account/app/modules/home/home_view.dart';
import 'package:account/app/modules/route/route_binding.dart';
import 'package:account/app/modules/route/route_view.dart';
import 'package:get/get.dart';

import '../modules/all_more/more/more_binding.dart';
import '../modules/all_more/more/more_view.dart';
import '../modules/all_more/my_book/my_book_binding.dart';
import '../modules/all_more/my_book/my_book_view.dart';
import '../modules/all_more/setting/setting_binding.dart';
import '../modules/all_more/setting/setting_view.dart';
import '../modules/dream/dream_binding.dart';
import '../modules/image_analyse/image_analyse_binding.dart';
import '../modules/image_analyse/image_analyse_view.dart';
import '../modules/table_analyse/table_analyse_binding.dart';
import '../modules/table_analyse/table_analyse_view.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    // GetPage(name: Routes.intro, page: () => const IntroPage()),
    GetPage(
        name: Routes.route, page: () => RoutePage(), binding: RouteBinding()),
    GetPage(
      name: Routes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.analyse,
      page: () => AnalysePage(),
      binding: AnalyseBinding(),
    ),
    GetPage(
      name: Routes.more,
      page: () => MorePage(),
      binding: MoreBinding(),
    ),
    // GetPage(
    //     name: Routes.login,
    //     page: () => const LoginPage(),
    //     binding: LoginBinding()),
    // GetPage(
    //     name: Routes.register,
    //     page: () => RegisterPage(),
    //     binding: RegisterBinding()),
    GetPage(name: Routes.add, page: () => AddPage(), binding: AddBinding()),
    GetPage(
        name: Routes.myBook,
        page: () => MyBookPage(),
        binding: MyBookBinding()),
    GetPage(
      name: Routes.imageAnalyse,
      page: () => ImageAnalysePage(),
      binding: ImageAnalyseBinding(),
    ),
    GetPage(
      name: Routes.tableAnalyse,
      page: () => TableAnalysePage(),
      binding: TableAnalyseBinding(),
    ),
    GetPage(
      name: Routes.dream,
      page: () => DreamPage(),
      binding: DreamBinding(),
    ),
    GetPage(
      name: Routes.setting,
      page: () => SettingPage(),
      binding: SettingBinding(),
    ),
  ];
}
