import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_text_theme.dart';

class MultiColumnRow extends StatelessWidget {
  final List<String> titles;
  final List<String>? subTitles;
  final CrossAxisAlignment crossAxisAlignment;
  final bool hasDivider;
  final TextStyle? decTextStyle;
  final TextStyle? numTextStyle;

  const MultiColumnRow({required this.titles,
    this.subTitles,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.hasDivider = false,
    this.decTextStyle,
    this.numTextStyle,
    Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (var i = 0; i < titles.length; i++) {
      if (hasDivider && i != 0) {
        children.add(
          SizedBox(
            height: 30.h,
            child: const VerticalDivider(
              thickness: 2,
            ),
          ),
        );
      }
      children.add(
        _OneColumn(
          title: titles[i],
          subTitle: subTitles == null ? null : subTitles![i],
          crossAxisAlignment: crossAxisAlignment,
          decTextStyle: decTextStyle ?? AppTS.small,
          numTextStyle: numTextStyle ?? AppTS.normal,
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children,
    );
  }
}

class _OneColumn extends StatelessWidget {
  final String title;
  final String? subTitle;
  final CrossAxisAlignment crossAxisAlignment;
  final TextStyle? decTextStyle;
  final TextStyle? numTextStyle;

  const _OneColumn({required this.title,
    required this.subTitle,
    required this.crossAxisAlignment,
    this.decTextStyle,
    this.numTextStyle,
    Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(title, style: numTextStyle),
        SizedBox(height: 5),
        if (subTitle != null) Text(subTitle!, style: decTextStyle)
      ],
    );
  }
}
