import 'package:account/app/theme/app_sizes.dart';
import 'package:flutter/material.dart';

class MyIconBtn extends StatelessWidget {
  final VoidCallback? onPressed;
  final String imgPath;
  final EdgeInsetsGeometry? margin;
  final Color color;

  const MyIconBtn({
    required this.onPressed,
    required this.imgPath,
    required this.color,
    this.margin,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.all(8),
      child: Material(
        color: Colors.white,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: IconButton(
          padding: const EdgeInsets.all(5),
          icon: Image.asset(
            imgPath,
            height: AppSizes.iconBtn,
            width: AppSizes.iconBtn,
            color: color,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
