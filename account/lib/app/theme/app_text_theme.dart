import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/mmkv.dart';
import 'app_string.dart';

class AppTS {
  static TextStyle textTitle = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    wordSpacing: 4,
    fontFamily: "Roboto",
  );
  static TextStyle textTitle2 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    wordSpacing: 4,
    fontFamily: "Roboto",
  );
  static TextStyle textBody = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    wordSpacing: 2,
    fontFamily: "Roboto",
  );

  static TextStyle topBarTitle = TextStyle(fontSize: 24.sp);
  static int version = MMKVUtil.getInt(AppString.mmVersion);

  static TextStyle get minor =>
      TextStyle(
        fontSize: version == 0 ? 10.sp : 12.sp,
        color: const Color(0xff3D3D3D),
      );

  static TextStyle get small =>
      TextStyle(
          fontSize: version == 0 ? 16.sp : 19.sp,
          color: const Color(0xff3D3D3D));

  static TextStyle get normal =>
      TextStyle(
          fontSize: version == 0 ? 20.sp : 24.sp,
          color: const Color(0xff3D3D3D));

  static TextStyle get big =>
      TextStyle(
          fontSize: version == 0 ? 24.sp : 29.sp,
          color: const Color(0xff3D3D3D));

  static TextStyle get big32 =>
      TextStyle(
          fontSize: version == 0 ? 32.sp : 40.sp,
          color: const Color(0xff3D3D3D));

  static TextStyle get large =>
      TextStyle(
          fontSize: version == 0 ? 40.sp : 48.sp,
          color: const Color(0xff3D3D3D));
  static TextStyle large48 =
  TextStyle(fontSize: 48.sp, color: const Color(0xff3D3D3D));

  static void changeVersion(int i) {
    version = i;
  }
}
