import 'package:account/app/component/lines_text.dart';
import 'package:account/app/component/mytopbarnormal.dart';
import 'package:account/app/theme/app_text_theme.dart';
import 'package:account/res/assets_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../theme/app_colors.dart';
import 'dream_logic.dart';

class DreamPage extends StatelessWidget {
  const DreamPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<DreamLogic>();
    final state = Get.find<DreamLogic>().state;

    return Scaffold(
      // appBar: MyTopBar(
      //   middle: Text(
      //     '梦想储蓄罐',
      //     style: AppTS.normal,
      //   ),
      // ),
      body: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.color_list[1].withAlpha(0),
              AppColors.color_list[1],
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const MyTopBarN(title: "梦想储蓄罐"),
              const Spacer(flex: 1),
              Container(
                height: 580.h,
                width: 300.w,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetsRes.BOTTLE),
                    fit: BoxFit.cover,
                  ),
                ),
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 75.h),
                  child: CircularPercentIndicator(
                    lineWidth: 15,
                    circularStrokeCap: CircularStrokeCap.round,
                    radius: 260.w / 3,
                    animation: true,
                    percent: 0.8,
                    backgroundColor: AppColors.color_list[0],
                    progressColor: AppColors.color_list.last,
                    center: LinesTextItem(
                      texts: const ["80%", "完成"],
                      styles: [AppTS.large, AppTS.small],
                    ),
                  ),
                ),
              ),
              Text(
                "距离当前目标还有20%，200元",
                style: AppTS.small,
              ),
              const Spacer(flex: 1),
              ElevatedButton(
                style: ButtonStyle(
                  shape: const MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                  ),
                  backgroundColor:
                      MaterialStatePropertyAll(AppColors.color_list.last),
                  fixedSize: MaterialStatePropertyAll(Size.fromWidth(300.w)),
                ),
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("设定目标",
                      style: AppTS.big.copyWith(
                          color: AppColors.textColor(AppColors.color_list.last))),
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
