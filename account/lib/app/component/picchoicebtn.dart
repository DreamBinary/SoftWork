import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_theme.dart';

class PicChoiceBtn extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? fontSize;

  const PicChoiceBtn(
      {required this.onPressed, required this.title, this.fontSize, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.color_list[2]),
          fixedSize: MaterialStateProperty.all(Size(double.maxFinite, 40.h)),
          shape: MaterialStateProperty.all(const StadiumBorder())),
      onPressed: () {
        Get.back();
        onPressed();
      },
      child: Text(
        title,
        style: AppTS.small.copyWith(
            color: AppColors.textColor(AppColors.color_list[2]),
            fontSize: fontSize),
      ),
    ).paddingSymmetric(horizontal: 1);
  }
}
