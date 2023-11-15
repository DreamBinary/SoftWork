import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_text_theme.dart';
import 'mytopbar.dart';

class MyTopBarN extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const MyTopBarN({required this.title, this.trailing, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: SizedBox(
        height: 56.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const MyBackButton(
              color: Colors.white,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTS.normal,
            ),
            trailing ??
                const Opacity(
                  opacity: 0,
                  child: MyBackButton(),
                ),
          ],
        ),
      ),
    );
  }
}
