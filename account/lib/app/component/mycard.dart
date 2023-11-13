import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final Color color;
  final double? height;
  final double? width;
  final GestureTapCallback? onPressed;
  final Widget? child;
  final double? elevation;

  const MyCard(
    this.color, {
    super.key,
    this.height,
    this.width,
    this.onPressed,
    this.elevation = 10,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: elevation,
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: onPressed,
        child: Container(
          height: height,
          width: width,
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}
