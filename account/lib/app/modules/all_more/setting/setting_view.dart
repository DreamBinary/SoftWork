import 'package:account/app/component/mytopbar.dart';
import 'package:account/app/component/version_ctrl.dart';
import 'package:account/app/modules/all_more/setting/person/person_view.dart';
import 'package:account/app/routes/app_pages.dart';
import 'package:account/app/theme/app_colors.dart';
import 'package:account/res/assets_res.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../theme/app_string.dart';
import '../../../theme/app_text_theme.dart';
import '../../../utils/mmkv.dart';
import '../../../utils/toast.dart';
import 'setting_logic.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    int version = VersionCtrl
        .of(context)
        ?.version ?? 0;
    final logic = Get.find<SettingLogic>();
    final state = Get
        .find<SettingLogic>()
        .state;

    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: MyTopBar(
        middle: Text(
          "设置",
          style: AppTS.normal,
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 300.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              _PersonBgButton(
                height: 160.h,
                width: double.maxFinite,
                color: AppColors.color_list[1],
                imgPath: AssetsRes.PERSON_BG0,
                child: Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                  width: double.maxFinite,
                  height: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "¥1236.1",
                        style: AppTS.normal.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor(AppColors.color_list[1]),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "**** **** **** 1458",
                        style: AppTS.normal.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor(AppColors.color_list[1]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _PersonBgOpenButton(
                    height: 80.w,
                    width: 135.w,
                    color: version != 0
                        ? AppColors.color_list[0]
                        : AppColors.color_list[3],
                    imgPath: AssetsRes.PERSON_BG1,
                    openBuilder: (BuildContext context,
                        void Function({dynamic returnValue}) action) {
                      return const PersonPage();
                    },
                    child: Text(
                      "个性化",
                      style: AppTS.big.copyWith(
                        color: AppColors.textColor(
                          version != 0
                              ? AppColors.color_list[0]
                              : AppColors.color_list[3],
                        ),
                      ),
                    ),
                  ),
                  _PersonBgButton(
                    height: 80.w,
                    width: 135.w,
                    color: version != 0
                        ? AppColors.color_list[0]
                        : AppColors.color_list[5],
                    imgPath: AssetsRes.PERSON_BG2,
                    onPressed: () {
                      VersionCtrl.of(context)?.changeVersion(
                        VersionCtrl
                            .of(context)
                            ?.version == 0 ? 1 : 0,
                      );
                      Get.offAllNamed(Routes.route);
                    },
                    child: Text(
                      VersionCtrl
                          .of(context)
                          ?.version == 0 ? "极简版" : "丰富版",
                      style: AppTS.big.copyWith(
                        color: AppColors.textColor(
                          version != 0
                              ? AppColors.color_list[0]
                              : AppColors.color_list[5],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              _PersonButton(
                imgPath: AssetsRes.PERSON_ICON2,
                color: AppColors.color_list[2],
                title: "账号设置",
                onTap: () {
                  // todo
                },
              ),
              SizedBox(height: 20.h),
              _PersonButton(
                imgPath: AssetsRes.PERSON_ICON2,
                color: AppColors.color_list[1],
                title: "退出登录",
                onTap: () {
                  try {
                    MMKVUtil.clear();
                    MMKVUtil.put(AppString.mmIsIntro, true);
                  } catch (e) {
                    debugPrint(e.toString());
                    return;
                  }
                  Get.offAllNamed(Routes.login);
                  ToastUtil.showToast("退出成功");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PersonBgOpenButton extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  final Color color;
  final String imgPath;
  final OpenContainerBuilder openBuilder;

  const _PersonBgOpenButton({
    Key? key,
    required this.height,
    required this.width,
    required this.child,
    required this.color,
    required this.imgPath,
    required this.openBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      closedElevation: 3,
      closedBuilder: (BuildContext context, void Function() action) {
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: color.withAlpha(123),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Image.asset(
                imgPath,
                color: color,
                height: double.maxFinite,
                width: double.maxFinite,
                fit: BoxFit.fill,
              ),
              Center(
                child: child,
              ),
            ],
          ),
        );
      },
      openBuilder: openBuilder,
    );
  }
}

class _PersonBgButton extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  final Color color;
  final String imgPath;
  final VoidCallback? onPressed;

  const _PersonBgButton({Key? key,
    required this.height,
    required this.width,
    required this.child,
    required this.color,
    required this.imgPath,
    this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 3,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: color.withAlpha(123),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Image.asset(
                imgPath,
                color: color,
                height: double.maxFinite,
                width: double.maxFinite,
                fit: BoxFit.fill,
              ),
              Center(
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PersonOpenButton extends StatelessWidget {
  final String title;
  final String imgPath;
  final OpenContainerBuilder openBuilder;
  final Color color;

  const _PersonOpenButton({required this.imgPath,
    required this.title,
    required this.color,
    required this.openBuilder,
    Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      closedElevation: 3,
      closedBuilder: (BuildContext context, void Function() action) {
        return Container(
          decoration: ShapeDecoration(
            color: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Image.asset(
                imgPath,
                height: 35,
                width: 35,
              ),
              SizedBox(width: 10.w),
              Text(title,
                  style:
                  AppTS.normal.copyWith(color: AppColors.textColor(color))),
              const Spacer(),
            ],
          ),
        );
      },
      openBuilder: openBuilder,
    );
  }
}

class _PersonButton extends StatelessWidget {
  final String title;
  final String imgPath;
  final Color color;
  final GestureTapCallback? onTap;

  const _PersonButton({required this.imgPath,
    required this.title,
    required this.color,
    this.onTap,
    Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 3,
        child: Container(
          decoration: ShapeDecoration(
            color: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Image.asset(
                imgPath,
                height: 35,
                width: 35,
              ),
              SizedBox(width: 10.w),
              Text(title,
                  style:
                  AppTS.normal.copyWith(color: AppColors.textColor(color))),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
