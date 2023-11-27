import 'package:account/app/component/version_ctrl.dart';
import 'package:account/app/routes/app_pages.dart';
import 'package:account/app/theme/app_colors.dart';
import 'package:account/app/theme/app_text_theme.dart';
import 'package:account/res/assets_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:status_bar_control/status_bar_control.dart';

import '../../theme/app_string.dart';
import '../../utils/mmkv.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  List<String> paths = [
    AssetsRes.INTRO0,
    AssetsRes.INTRO1,
    AssetsRes.INTRO2,
    AssetsRes.INTRO3,
  ];

  PageController controller = PageController(initialPage: 0);

  int _modeIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: List.generate(
          4,
              (index) =>
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(paths[index]),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Stack(
                  children: [
                    if (index == 3)
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _ModeCard(
                              isBig: _modeIndex == -1 || _modeIndex == 0,
                              hasBorder: _modeIndex == 0,
                              shadowColor: const Color(0xffECD2A8),
                              borderColor: const Color(0xffFFCC7C),
                              pathSelect: AssetsRes.MODE0,
                              pathUnSelect: AssetsRes.MODE00,
                              onTap: () {
                                setState(() {
                                  _modeIndex = 0;
                                });
                              },
                            ),
                            if (_modeIndex == 0)
                              const _ModeIntro(
                                titles: [
                                  "· 功能完整",
                                  "· 界面美观，布局新颖",
                                  "· 适合青年人使用",
                                ],
                              ),
                            if (_modeIndex == 1)
                              const _ModeIntro(
                                titles: [
                                  "· 仅保留核心功能",
                                  "· 图标显眼，文字清晰",
                                  "· 适合中老年人使用",
                                ],
                              ),

                            _ModeCard(
                              isBig: _modeIndex == -1 || _modeIndex == 1,
                              hasBorder: _modeIndex == 1,
                              shadowColor: const Color(0xffCACFAD),
                              borderColor: const Color(0xffB9CB70),
                              pathSelect: AssetsRes.MODE1,
                              pathUnSelect: AssetsRes.MODE11,
                              onTap: () {
                                setState(() {
                                  _modeIndex = 1;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: _IndicatorPart(
                        controller: controller,
                        index: index,
                        onEnd: () {
                          if (_modeIndex == -1) {
                            _modeIndex = 0;
                          }
                          MMKVUtil.put(AppString.mmIsIntro, true);
                          VersionCtrl.of(context)?.changeVersion(_modeIndex);
                          Get.offAllNamed(Routes.login);
                        },
                      ),
                    )
                  ],
                ),
              ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    StatusBarControl.setHidden(true, animation: StatusBarAnimation.SLIDE);
  }

  @override
  void dispose() {
    super.dispose();
    StatusBarControl.setHidden(false, animation: StatusBarAnimation.SLIDE);
  }
}

class _ModeCard extends StatelessWidget {
  final bool isBig;
  final bool hasBorder;
  final Color shadowColor;
  final Color borderColor;
  final String pathSelect;
  final String pathUnSelect;
  final GestureTapCallback? onTap;

  const _ModeCard({required this.isBig,
    required this.hasBorder,
    required this.shadowColor,
    required this.borderColor,
    required this.pathSelect,
    required this.pathUnSelect,
    this.onTap,
    Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Material(
          elevation: 10,
          shadowColor: shadowColor,
          shape: RoundedRectangleBorder(
              side: hasBorder
                  ? BorderSide(
                color: borderColor,
                width: 6,
                strokeAlign: BorderSide.strokeAlignOutside,
              )
                  : BorderSide.none,
              borderRadius: BorderRadius.circular(20)),
          child: isBig
              ? Container(
            height: 200.h,
            width: 280.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(pathSelect),
                  fit: BoxFit.fill,
                ),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor,
                    offset: const Offset(2, 2),
                    blurRadius: 12,
                    spreadRadius: 3,
                  ),
                ]),
          )
              : Container(
            height: 100.h,
            width: 280.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(pathUnSelect),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}

class _ModeIntro extends StatelessWidget {
  final List<String> titles;

  const _ModeIntro({required this.titles, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titles[0],
            style: AppTS.normal,
          ),
          const SizedBox(height: 5),
          Text(
            titles[1],
            style: AppTS.normal,
          ),
          const SizedBox(height: 5),
          Text(
            titles[2],
            style: AppTS.normal,
          ),
        ],
      ),
    );
  }
}

class _IndicatorPart extends StatelessWidget {
  final PageController controller;
  final int index;
  final VoidCallback onEnd;

  const _IndicatorPart({required this.controller,
    required this.index,
    required this.onEnd,
    Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SmoothPageIndicator(
          count: 4,
          effect: const WormEffect(
            dotWidth: 12,
            dotHeight: 12,
            activeDotColor: AppColors.color5,
            dotColor: AppColors.color3,
            strokeWidth: 2,
          ),
          controller: controller,
        ),
        SizedBox(height: 10.h),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(), backgroundColor: AppColors.color5),
          onPressed: () {
            if (index == 3) {
              onEnd();
              return;
            }
            controller.animateToPage(index + 1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
            child: Text(
              "下一步",
              style: AppTS.normal.copyWith(
                color: AppColors.textColor(AppColors.color5),
              ),
            ),
          ),
        ),
        SizedBox(height: 60.h)
      ],
    );
  }
}
