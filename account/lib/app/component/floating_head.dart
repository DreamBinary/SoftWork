import 'package:account/res/assets_res.dart';
import 'package:app_to_foreground/app_to_foreground.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class FloatingHead extends StatefulWidget {
  const FloatingHead({Key? key}) : super(key: key);

  @override
  State<FloatingHead> createState() => _FloatingHeadState();
}

class _FloatingHeadState extends State<FloatingHead> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 0.0,
      child: GestureDetector(
        onTap: () {
          AppToForeground.appToForeground();
          FlutterOverlayWindow.closeOverlay();
        },
        child: FittedBox(
          child: Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetsRes.LOGO),
                fit: BoxFit.cover,
              ),
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            // child: Image.asset(AssetsRes.LOGO, height: 100, width: 100,),
          ),
        ),
      ),
    );
  }
}
