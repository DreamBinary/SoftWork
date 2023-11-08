import 'package:account/app/component/my_header/header_logic.dart';
import 'package:account/app/component/mytopbar.dart';
import 'package:account/app/routes/app_pages.dart';
import 'package:account/app/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../component/my_header/header_view.dart';
import '../../../component/mycard.dart';
import '../../../component/version_ctrl.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_theme.dart';
import '../report_view.dart';
import 'more_logic.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    // return const _SMorePage();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.color_list[1],
            AppColors.whiteBg,
            AppColors.whiteBg,
            AppColors.whiteBg,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: VersionCtrl.of(context)?.version != 0
          ? const _SMorePage()
          : const _MMorePage(),
    );
  }
}

class _SMorePage extends StatelessWidget {
  const _SMorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(height: 66.h),
            Row(
              children: [
                const HeaderComponent(),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        "啊哈哈哈",
                        style: AppTS.big,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "手机号: 10086",
                        style: AppTS.normal,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 20.h),
            LayoutBuilder(
              builder: (context, constraint) {
                return MyCard(
                  AppColors.color_list[1],
                  height: constraint.constrainWidth() / 3,
                  onPressed: () {
                    Get.toNamed(Routes.myBook);
                  },
                  child: Text("我的账本",
                      style: AppTS.large48.copyWith(
                          color: AppColors.textColor(AppColors.color_list[1]))),
                );
              },
            ),
            SizedBox(height: 8.h),
            LayoutBuilder(
              builder: (context, constraint) {
                double h = constraint.constrainWidth() * 10.0 / 21;
                return Row(
                  children: [
                    Expanded(
                      flex: 15,
                      child: MyCard(
                        AppColors.color_list[0],
                        height: 2 * h + 10.h,
                        onPressed: () {
                          Get.toNamed(Routes.dream);
                        },
                        child: Text(
                          "梦\n想\n储\n蓄\n罐",
                          style: AppTS.big32.copyWith(
                            color: AppColors.textColor(AppColors.color_list[0]),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(flex: 1),
                    Expanded(
                      flex: 15,
                      child: SizedBox(
                        height: 2 * h + 10.h,
                        child: Column(
                          children: [
                            Expanded(
                              child: MyCard(
                                AppColors.color_list[0],
                                onPressed: () {
                                  Get.to(const ReportPage());
                                },
                                child: Text(
                                  "报告",
                                  style: AppTS.big32.copyWith(
                                    color: AppColors.textColor(
                                        AppColors.color_list[0]),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Expanded(
                              child: MyCard(
                                AppColors.color_list[1],
                                height: h,
                                onPressed: () {
                                  Get.toNamed(Routes.setting);
                                },
                                child: Text(
                                  "设置",
                                  style: AppTS.big32.copyWith(
                                    color: AppColors.textColor(
                                        AppColors.color_list[1]),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ]),
        ),
      ),
    );
  }
}

class _MMorePage extends StatelessWidget {
  const _MMorePage({Key? key}) : super(key: key);
  final remain = 1940.00;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(height: 66.h),
            const HeaderComponent(),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "啊哈哈哈",
                style: AppTS.normal,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "手机号: 10086",
                style: AppTS.small,
              ),
            ),
            SizedBox(height: 10.h),
            LayoutBuilder(
              builder: (context, constraint) {
                double h = (constraint.constrainWidth() - 15) / 3.0;
                return SizedBox(
                  height: 2 * h + 15,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: MyCard(
                          AppColors.color_list[1],
                          onPressed: () {
                            Get.toNamed(Routes.myBook);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("我的账本",
                                  style: AppTS.big32.copyWith(
                                      color: AppColors.textColor(
                                          AppColors.color_list[1]))),
                              SizedBox(height: 10.h),
                              Text("总余额",
                                  style: AppTS.small.copyWith(
                                      color: AppColors.textColor(
                                          AppColors.color_list[1]))),
                              SizedBox(height: 5.h),
                              Text(
                                remain.moneyFormatZero,
                                style: AppTS.big.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textColor(
                                        AppColors.color_list[1])),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Expanded(
                              child: MyCard(
                                AppColors.color_list[2],
                                onPressed: () {
                                  Get.toNamed(Routes.setting);
                                },
                                child: Text(
                                  "设置",
                                  style: AppTS.normal.copyWith(
                                    color: AppColors.textColor(
                                        AppColors.color_list[2]),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Expanded(
                              child: MyCard(
                                AppColors.color_list[3],
                                onPressed: () {
                                  Get.to(const ReportPage());
                                },
                                child: Text(
                                  "报告",
                                  style: AppTS.normal.copyWith(
                                    color: AppColors.textColor(
                                        AppColors.color_list[3]),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 15),
            LayoutBuilder(builder: (context, constraint) {
              return Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: MyCard(
                      AppColors.color_list[3],
                      height: constraint.constrainWidth() * 10 / 31,
                      onPressed: () {
                        // todo
                      },
                      child: Text(
                        "敬请期待",
                        style: AppTS.normal.copyWith(
                          color: AppColors.textColor(AppColors.color_list[3]),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    flex: 20,
                    child: MyCard(
                      AppColors.color_list[5],
                      height: constraint.constrainWidth() * 10 / 31,
                      onPressed: () {
                        Get.toNamed(Routes.dream);
                      },
                      child: Text(
                        "梦想储蓄罐",
                        style: AppTS.normal.copyWith(
                          color: AppColors.textColor(AppColors.color_list[5]),
                        ),
                      ),
                    ),
                  )
                ],
              );
            })
          ]),
        ),
        // bottomNavigationBar: const MyBottomBarPlaceholder(),
      ),
    );
  }
}
