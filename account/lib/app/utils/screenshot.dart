import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class ScreenShotUtil {

  static const MethodChannel _channel = MethodChannel(
      "com.cxq.account/ScreenShotChannel");

  static Future<void> readyScreenShot() async {
    final String? result = await _channel.invokeMethod('start');
    debugPrint('readyScreenShot: $result');
  }

  static Future<String?> takeScreenshot() async {
    final String? path = await _channel.invokeMethod('stop');
    return path;
  }

}