import 'package:account/app/component/mybottombar.dart';
import 'package:account/app/component/version_ctrl.dart';
import 'package:account/app/modules/home/home_view.dart';
import 'package:account/app/theme/app_text_theme.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screen_capture_event/screen_capture_event.dart';

import '../../../res/assets_res.dart';
import '../../component/croping_page.dart';
import '../../component/myshowbottomsheet.dart';
import '../../component/picchoicebtn.dart';
import '../../component/sound_page.dart';
import '../../data/net/api_img.dart';
import '../../routes/app_pages.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_string.dart';
import '../../utils/camera_util.dart';
import '../../utils/floating_util.dart';
import '../../utils/mmkv.dart';
import '../all_more/more/more_view.dart';
import '../analyse/analyse_view.dart';
import 'route_logic.dart';

class RoutePage extends StatelessWidget {
  const RoutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (VersionCtrl.of(context)?.version != 0) {
      return const _SRoutePage();
    }
    return const _MRoutePage();
  }
}

class _MRoutePage extends StatefulWidget {
  const _MRoutePage({Key? key}) : super(key: key);

  @override
  State<_MRoutePage> createState() => _MRoutePageState();
}

class _MRoutePageState extends State<_MRoutePage> {
  PageController ctrl = PageController(initialPage: 1);
  final pages = const [
    AnalysePage(),
    HomePage(),
    MorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color_list[1],
      body: PageView(
        controller: ctrl,
        children: List.generate(pages.length, (index) => pages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: MyBottomBar(
        color: AppColors.color_list[1],
        pageController: ctrl,
        bottomBarItems: [
          BottomBarItem(
              inActiveItem: Image.asset(
                AssetsRes.BOTTOM_ITEM0,
                width: 24,
                height: 24,
              ),
              activeItem: Image.asset(
                AssetsRes.BOTTOM_ITEM0,
                width: 30,
                height: 30,
              ),
              itemLabel: "收支分析"),
          BottomBarItem(
              inActiveItem: Image.asset(
                AssetsRes.BOTTOM_ITEM1,
                width: 24,
                height: 24,
              ),
              activeItem: Image.asset(
                AssetsRes.BOTTOM_ITEM1,
                width: 30,
                height: 30,
              ),
              itemLabel: "首页"),
          BottomBarItem(
              inActiveItem: Image.asset(
                AssetsRes.BOTTOM_ITEM2,
                width: 24,
                height: 24,
              ),
              activeItem: Image.asset(
                AssetsRes.BOTTOM_ITEM2,
                width: 30,
                height: 30,
              ),
              itemLabel: "更多"),
        ],
        onTap: (index) {
          setState(
            () {
              ctrl.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          );
        },
      ),
    );
  }
}

class _SRoutePage extends StatefulWidget {
  const _SRoutePage({Key? key}) : super(key: key);

  @override
  State<_SRoutePage> createState() => _SRoutePageState();
}

class _SRoutePageState extends State<_SRoutePage>
    with TickerProviderStateMixin {
  late TabController ctrl =
      TabController(initialIndex: 0, length: 2, vsync: this);

  final pages = const [
    HomePage(),
    MorePage(),
  ];

  int currentIndex = 0;

  final ScreenCaptureEvent screenListener = ScreenCaptureEvent();

  @override
  void initState() {
    super.initState();
    screenListener.addScreenShotListener(
      (filePath) async {
        // print(filePath);
        FloatingUtil.end();
        await Future.delayed(const Duration(milliseconds: 100));
        var urls = await ApiImg.upImg(imgPaths: [filePath]);
        Get.to(CroppingPage(
            fileName: urls[0].split('/').last, isScreenShot: true));
        screenListener.dispose();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color_list[1],
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.color_list.last,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        selectedLabelStyle: AppTS.small.copyWith(color: Colors.white),
        unselectedLabelStyle: AppTS.small.copyWith(color: Colors.white),
        useLegacyColorScheme: false,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.only(bottom: 5),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: currentIndex == 0
                    ? AppColors.color_list[0]
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                AssetsRes.BOTTOM_ITEM1,
                color: AppColors.textColor(AppColors.color_list[0]),
              ),
            ),
            label: "首页",
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.only(bottom: 5),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: currentIndex == 1
                    ?  AppColors.color_list[0]
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                AssetsRes.BOTTOM_ITEM2,
                color: AppColors.textColor(AppColors.color_list[0]),
              ),
            ),
            label: "更多",
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: PhysicalModel(
        color: Colors.transparent,
        shape: BoxShape.circle  ,
        elevation: 10,
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.whiteBg,
              width: 2,
            ),
            shape: BoxShape.circle,
          ),
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: AppColors.color_list[0],
              onPressed: () {
                Get.to(() => const SoundPage());
              },
              child: Icon(
                Icons.mic_none_rounded,
                size: 40,
                color: AppColors.textColor(AppColors.color_list[0]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _getCameraChoice() {
    myShowBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20.h),
          PicChoiceBtn(
            title: "截屏",
            onPressed: () async {
              screenListener.watch();
              await FloatingUtil.start();
            },
          ),
          SizedBox(height: 10.h),
          PicChoiceBtn(
            title: "拍照",
            onPressed: () async {
              XFile? image = await CameraUtil.getCamera();
              if (image == null) {
                return;
              }
              List<String> urls = await CameraUtil.upImg(image);
              Get.to(CroppingPage(fileName: urls[0].split('/').last));
            },
          ),
          SizedBox(height: 10.h),
          PicChoiceBtn(
            title: "相册",
            onPressed: () async {
              XFile? image = await CameraUtil.getGallery();
              if (image == null) {
                return;
              }
              List<String> urls = await CameraUtil.upImg(image);
              Get.to(CroppingPage(fileName: urls[0].split('/').last));
            },
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
