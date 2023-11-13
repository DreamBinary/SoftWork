import 'package:app_to_foreground/app_to_foreground.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:move_to_background/move_to_background.dart';

class FloatingUtil {
  static start() async {
    if (!await FlutterOverlayWindow.isPermissionGranted()) {
      await FlutterOverlayWindow.requestPermission();
    }
    await FlutterOverlayWindow.showOverlay(
      overlayTitle: "悬浮窗",
      overlayContent: '悬浮窗开启',
      flag: OverlayFlag.defaultFlag,
      alignment: OverlayAlignment.centerLeft,
      visibility: NotificationVisibility.visibilityPublic,
      positionGravity: PositionGravity.auto,
      enableDrag: true,
      height: 120,
      width: 120,
    );
    MoveToBackground.moveTaskToBack();
  }

  static end() async {
    AppToForeground.appToForeground();
    await FlutterOverlayWindow.closeOverlay();
  }
}
