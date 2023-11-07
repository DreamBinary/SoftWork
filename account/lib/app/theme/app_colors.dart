import 'dart:math';

import 'package:account/app/theme/app_string.dart';
import 'package:account/app/utils/mmkv.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const Color grey = Color(0xFF747474);
  static const Color primary = Color(0xff4F6B42);
  static const Color divider = Color(0xFFBDBDBD);

  static const Color classBg = Color(0xffCDD1BB);
  static const Color whiteBg = Color.fromARGB(255, 245, 245, 245);

  static const Color color0 = Color(0xffF8F5D2);
  static const Color color1 = Color(0xffF2EDAC);
  static const Color color2 = Color(0xffECD283);
  static const Color color3 = Color(0xffABB38D);
  static const Color color4 = Color(0xffA3A871);
  static const Color color5 = Color(0xff4F6B42);

  static Color textColor(Color color) {
    return color.computeLuminance() > 0.5
        ? const Color(0xff3D3D3D)
        : Colors.white;
  }

  static List<Color> color_list = getColor();

  static void changeColor(int i) {
    currentIndex = i;
    color_list = getColor(i: i);
  }

  static int currentIndex = MMKVUtil.getInt(AppString.mmColor);
  static int version = MMKVUtil.getInt(AppString.mmVersion);

  static changeVersion(int i) {
    version = i;
    color_list = getColor();
  }

  static List<Color> getColor({int? i}) {
    i = i ?? currentIndex;
    if (version != 0) {
      switch (i) {
        case 0:
          return color_list20;
        case 1:
          return color_list21;
        case 2:
          return color_list22;
        case 3:
          return color_list23;
        case 4:
          return color_list24;
        case 5:
          return color_list25;
        case 6:
        default:
          return color_list20;
      }
    } else {
      switch (i) {
        case 0:
          return color_list0;
        case 1:
          return color_list1;
        case 2:
          return color_list2;
        case 3:
          return color_list3;
        case 4:
          return color_list4;
        case 5:
          return color_list5;
        case 6:
        default:
          return color_list0;
      }
    }
  }

  static const List<Color> color_list0 = [
    Color(0xffF8F5D2), // 0
    Color(0xffF2EDAC), // 1 // background
    Color(0xffECD283), // 2
    Color(0xffABB38D), // 3
    Color(0xffA3A871), // 4
    Color(0xff4F6B42), // 5
  ];

  // static const List<Color> color_list1 = [
  //   Color(0xffC8CCBE),
  //   Color(0xffA4B3A0),
  //   Color(0xff5B6F64),
  //   Color(0xffE4D8C8),
  //   Color(0xffC4A4B2),
  //   Color(0xff9F838B),
  // ];
  static const List<Color> color_list1 = [
    Color(0xffE7D5BE),
    Color(0xffD5BFC2),
    Color(0xff995A70),
    Color(0xff846992),
    Color(0xff604771),
    Color(0xff3F3157),
  ];
  static const List<Color> color_list2 = [
    Color(0xffCFE3EE),
    Color(0xffB9DEE4),
    Color(0xff97D2F2),
    Color(0xff5292C0),
    Color(0xff3F689E),
    Color(0xff357568),
  ];
  static const List<Color> color_list3 = [
    Color(0xffF1E0DC),
    Color(0xffEECB87),
    Color(0xffDEA97F),
    Color(0xffA05E4E),
    Color(0xff945242),
    Color(0xff8E4C40),
  ];
  static const List<Color> color_list4 = [
    Color(0xffB9D89F),
    Color(0xffB9DEE7),
    Color(0xffA9D2C0),
    Color(0xff509880),
    Color(0xff4D7664),
    Color(0xff3D695A),
  ];
  static const List<Color> color_list5 = [
    Color(0xffF8D8D8),
    Color(0xffF0D0D8),
    Color(0xffE09090),
    Color(0xffF0B0B8),
    Color(0xffB06870),
    Color(0xffB87880),
  ];

  static const List<Color> color_list20 = [
    Color(0xffECD283),
    Color(0xff4F6B42),
    Color(0xffECD283),
    Color(0xff4F6B42),
    Color(0xffECD283),
    Color(0xff4F6B42),
  ];

  static const List<Color> color_list21 = [
    Color(0xffE7D5BE),
    Color(0xff995A70),
    Color(0xffE7D5BE),
    Color(0xff995A70),
    Color(0xffE7D5BE),
    Color(0xff995A70),
  ];

  static const List<Color> color_list22 = [
    Color(0xff97D2F2),
    Color(0xff3F689E),
    Color(0xff97D2F2),
    Color(0xff3F689E),
    Color(0xff97D2F2),
    Color(0xff3F689E),
  ];

  static const List<Color> color_list23 = [
    Color(0xffEECB87),
    Color(0xff8E4C40),
    Color(0xffEECB87),
    Color(0xff8E4C40),
    Color(0xffEECB87),
    Color(0xff8E4C40),
  ];

  static const List<Color> color_list24 = [
    Color(0xffB9D89F),
    Color(0xff509880),
    Color(0xffB9D89F),
    Color(0xff509880),
    Color(0xffB9D89F),
    Color(0xff509880),
  ];

  static const List<Color> color_list25 = [
    Color(0xffF0B0B8),
    Color(0xffB06870),
    Color(0xffF0B0B8),
    Color(0xffB06870),
    Color(0xffF0B0B8),
    Color(0xffB06870),
  ];

  static List<Color> randomColor({int num = 1}) {
    if (version != 0) {
      return _randomColor1(num: num);
    }
    return _randomColor0(num: num);
  }

  static List<Color> _randomColor0({int num = 1}) {
    if (num == 1) {
      return [color_list[Random().nextInt(color_list.length)]];
    }
    List<int> rIndexList = [];
    var rng = Random();
    int count = 0;
    int max = color_list.length;

    while (count < num && count < max) {
      int index = rng.nextInt(max);
      if (!rIndexList.contains(index)) {
        rIndexList.add(index);
        count++;
      }
    }
    List<int> indexList = [];
    if (count == num) {
      indexList.addAll(rIndexList);
    } else {
      int n = num ~/ max;
      int m = num % max;
      while (n > 0) {
        indexList.addAll(rIndexList);
        n--;
      }
      for (int i = 0; i < m; ++i) {
        indexList.add(indexList[i]);
      }
    }
    return List.generate(num, (index) => color_list[indexList[index]]);
  }

  static List<Color> _randomColor1({int num = 1}) {
    if (num == 1) {
      return [color_list[Random().nextInt(2)]];
    }
    List<int> rIndexList = [];
    var rng = Random();
    int count = 0;
    int max = 2;

    while (count < num && count < max) {
      int index = rng.nextInt(max);
      if (!rIndexList.contains(index)) {
        rIndexList.add(index);
        count++;
      }
    }
    List<int> indexList = [];
    if (count == num) {
      indexList.addAll(rIndexList);
    } else {
      int n = num ~/ max;
      int m = num % max;
      while (n > 0) {
        indexList.addAll(rIndexList);
        n--;
      }
      for (int i = 0; i < m; ++i) {
        indexList.add(indexList[i]);
      }
    }
    return List.generate(num, (index) => color_list[indexList[index]]);
  }
}
