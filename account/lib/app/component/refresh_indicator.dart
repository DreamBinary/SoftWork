import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../theme/app_colors.dart';

class MyRefreshIndicator extends StatelessWidget {
  const MyRefreshIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.discreteCircle(
      color: AppColors.color_list[5],
      size: 45,
      secondRingColor: AppColors.color_list[2],
      thirdRingColor: AppColors.color_list[1],
    );
  }
}
