import 'package:account/app/component/version_ctrl.dart';
import 'package:account/app/data/net/api_consume.dart';
import 'package:account/app/modules/all_entry/login/login_binding.dart';
import 'package:account/app/theme/app_string.dart';
import 'package:account/app/theme/app_text_theme.dart';
import 'package:account/app/utils/mmkv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mmkv/mmkv.dart';
import 'package:status_bar_control/status_bar_control.dart';
import 'package:statusbarz/statusbarz.dart';

import 'app/component/floating_head.dart';
import 'app/modules/route/route_binding.dart';
import 'app/routes/app_pages.dart';
import 'app/theme/app_colors.dart';

void main() async {
  final rootDir = await MMKV.initialize();
  // splash
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  StatusBarControl.setTranslucent(true);

  runApp(const MyApp());
}

@pragma("vm:entry-point")
void overlayMain() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FloatingHead(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int version = MMKVUtil.getInt(AppString.mmVersion);
  bool isLogin = MMKVUtil.getBool(AppString.mmIsLogin);
  bool isIntro = MMKVUtil.getBool(AppString.mmIsIntro);

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    Statusbarz.instance.setDefaultDelay = const Duration();
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return KeyboardDismissOnTap(
          child: StatusbarzCapturer(
            child: VersionCtrl(
              version: version,
              changeVersion: (v) {
                MMKVUtil.put(AppString.mmVersion, v);
                AppTS.changeVersion(v);
                AppColors.changeVersion(v);
                setState(
                      () {
                    version = v;
                  },
                );
              },
              child: GetMaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primaryColor: AppColors.primary,
                  fontFamily: "FZQKBYSJW",
                  colorScheme:
                  ColorScheme.fromSwatch(primarySwatch: Colors.grey)
                      .copyWith(background: AppColors.whiteBg),
                ),
                navigatorObservers: [Statusbarz.instance.observer],
                getPages: AppPages.pages,
                // // initialRoute: Routes.route,
                // initialRoute: Routes.intro,

                initialBinding: isIntro
                    ? (isLogin ? RouteBinding() : LoginBinding())
                    : null,
                initialRoute: isIntro
                    ? (isLogin ? Routes.route : Routes.login)
                    : Routes.intro,
                builder: (context, child) {
                  return SafeArea(top: false, child: child!);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
