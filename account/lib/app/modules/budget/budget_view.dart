import 'package:account/app/component/lines_text.dart';
import 'package:account/app/component/mycard.dart';
import 'package:account/app/component/myiconbtn.dart';
import 'package:account/app/component/mytopbar.dart';
import 'package:account/app/theme/app_colors.dart';
import 'package:account/app/theme/app_text_theme.dart';
import 'package:account/res/assets_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'budget_logic.dart';

class BudgetPage extends StatelessWidget {
  const BudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<BudgetLogic>();
    final state = Get
        .find<BudgetLogic>()
        .state;

    return Scaffold(
      appBar: MyTopBar(
        backgroundColor: AppColors.color_list[1],
        middle: Text(
          "预算详情与管理",
          style: AppTS.normal,
        ),
        trailing: MyIconBtn(
          onPressed: () {},
          imgPath: AssetsRes.BUDGET_TOP_ICON,
          color: AppColors.color_list[5],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            _BudgetCard(
              texts: const ["基础工资", "每月10日5000元"],
              bgColor: AppColors.color_list[5],
            ),
            SizedBox(
              height: 10.h,
            ),
            _BudgetCard(
              texts: const ["外快", "每月20日500元"],
              bgColor: AppColors.color_list[4],
            ),
          ],
        ),
      ),
    );
  }
}

class _BudgetCard extends StatelessWidget {
  final List<String> texts;
  final Color bgColor;

  const _BudgetCard({required this.texts, required this.bgColor, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
      bgColor,
      height: 90.h,
      child: Row(
        children: [
          SizedBox(
            width: 20.w,
          ),
          Image.asset(
            AssetsRes.BUDGET_ICON,
            height: 60,
            width: 60,
          ),
          SizedBox(
            width: 20.w,
          ),
          LinesTextItem(
            textAlign: CrossAxisAlignment.start,
            padding: EdgeInsets.symmetric(vertical: 5.h),
            texts: texts,
            styles: [
              AppTS.normal.copyWith(
                color: AppColors.textColor(bgColor),
              ),
              AppTS.small.copyWith(
                color: AppColors.textColor(bgColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}
