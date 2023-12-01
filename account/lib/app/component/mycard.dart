import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

class MyCard extends StatefulWidget {
  final Color color;
  final double? height;
  final double? width;
  final GestureTapCallback? onPressed;
  final Widget? child;
  final bool showBadge;
  final double elevation;
  final Function()? onBadgeTap;

  const MyCard(
    this.color, {
    super.key,
    this.height,
    this.width,
    this.showBadge = false,
    this.elevation = 10,
    this.onPressed,
    this.onBadgeTap,
    this.child,
  });

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  var showBadge = false;

  @override
  Widget build(BuildContext context) {
    var card = Card(
      color: widget.color,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: widget.elevation,
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: widget.onPressed,
        onLongPress: () {
          if (widget.showBadge) {
            setState(() {
              showBadge = !showBadge;
            });
          }
        },
        child: Container(
          height: widget.height,
          width: widget.width,
          alignment: Alignment.center,
          child: widget.child,
        ),
      ),
    );

    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: -10, end: -12),
      showBadge: showBadge,
      ignorePointer: false,
      onTap: widget.onBadgeTap,
      badgeContent: const Icon(Icons.clear),
      badgeAnimation: const badges.BadgeAnimation.rotation(
        animationDuration: Duration(seconds: 1),
        colorChangeAnimationDuration: Duration(seconds: 1),
        loopAnimation: false,
        curve: Curves.fastOutSlowIn,
        colorChangeAnimationCurve: Curves.easeInCubic,
      ),
      badgeStyle: badges.BadgeStyle(
        shape: badges.BadgeShape.circle,
        borderSide: BorderSide(color: widget.color, width: 3),
        badgeColor: Colors.white,
        borderRadius: BorderRadius.circular(4),
        elevation: 0,
      ),
      child: card,
    );
  }
}
