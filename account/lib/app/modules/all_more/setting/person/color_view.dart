import 'package:account/app/component/mytopbar.dart';
import 'package:account/app/theme/app_colors.dart';
import 'package:account/app/theme/app_text_theme.dart';
import 'package:account/res/assets_res.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../../theme/app_string.dart';
import '../../../../utils/mmkv.dart';

class ColorView extends StatefulWidget {
  ColorView({Key? key}) : super(key: key);

  @override
  State<ColorView> createState() => _ColorViewState();
}

class _ColorViewState extends State<ColorView> {

  final ExpandableController _ctrl = ExpandableController(
      initialExpanded: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyTopBar(
        middle: Text(
          "主题色",
          style: AppTS.normal,
        ),
      ),
      body: ExpandableTheme(
        data: const ExpandableThemeData(
          headerAlignment: ExpandablePanelHeaderAlignment.center,
          useInkWell: true,
        ),
        child: ExpandableNotifier(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExpandablePanel(
                  controller: _ctrl,
                  header: Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Text("第五套人民币", style: AppTS.normal),
                  ),
                  collapsed: const SizedBox(),
                  expanded: _ColorPart(),
                ),
                ExpandablePanel(
                  controller: ExpandableController(initialExpanded: false),
                  header: Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Text("第四套人民币", style: AppTS.normal),
                  ),
                  collapsed: const SizedBox(),
                  expanded: _ColorPart(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0, top: 10.0),
                  child: Text("敬请期待",
                      style: AppTS.normal.copyWith(color: Colors.grey)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ColorPart extends StatelessWidget {
  _ColorPart({Key? key}) : super(key: key);

  final List<Color> bgColors = const [
    Color(0xff86896B),
    Color(0xffC48DA0),
    Color(0xffA0C4DD),
    Color(0xffF2D69E),
    Color(0xff8EBCA8),
    Color(0xffD38484),
  ];

  final List<String> imgPaths = [
    AssetsRes.MONE,
    AssetsRes.MFIVE,
    AssetsRes.MTEN,
    AssetsRes.MTWENTY,
    AssetsRes.MFIFTY,
    AssetsRes.MHUNDRED,
  ];

  final List<String> titles = [
    "绿草如茵",
    "童话世界",
    "海阔天空",
    "丰收季节",
    "光明前途",
    "鸿运当头",
  ];

  final List<String> intros = [
    "    1元纸币的色调偏向草绿色，这种配色简约而清新，或明或暗的绿色交织，宛如雨后的青青草地，带来扑面而来的湿润气息，氤氲出夏日的水汽。",
    "    5元纸币是以紫色为基调的配色，轻柔的薰衣草紫可以和嫩绿色相搭配，既有温柔浪漫的张力又充满清新梦幻的活力，如同精灵在草丛中起舞，半透明的翅膀闪烁，一面是温柔一面是灵动",
    "    10元面值的纸币深蓝和浅蓝交织，雾霾蓝搭配同色调的灰粉色，以接近夏日的清凉诠释着色彩的感知，时而温文尔雅，时而波光潋滟，这种配色灵动且欢快。",
    "    20元面值的纸币配色以深棕色和浅度的粉色和绿色为主，在视觉上温润舒适，是大地的颜色，孕育着万物生灵，又如秋叶般沉静，这个色系的配色非常适合作为秋冬的穿搭借鉴，棕色搭配卡其色，低调沉稳宛如森林里枯叶碟，不显山露水，只有在挥动翅膀的时候会展示它无与伦比的美丽。",
    "    50元的纸币是以绿色为主色调，以辽阔的山河为背景，不同层次的绿色，辅以略带灰度的浅色调，这种配色，宛如碧绿的湖水倒映着青草，是自然的气息，这种绿色来自于山川湖泊，是治愈疲惫的一剂良方。",
    "    100的人民币，是面额最大的人民币，以玫红色为基调，融入透亮的粉色，这种红色毫不俗气，不同明度的红色和粉色搭配，清澈明亮，温暖热烈，带来青春的活力。",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: 450.h,
        child: Swiper(
          itemCount: bgColors.length,
          viewportFraction: 0.8,
          itemBuilder: (context, index) {
            List<Color> colorList = AppColors.getColor(i: index);
            return Padding(
              padding: EdgeInsets.all(20.h),
              child: Material(
                clipBehavior: Clip.hardEdge,
                color: Colors.transparent,
                elevation: 10,
                borderRadius: BorderRadius.circular(20.h),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: bgColors[index],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, constraint) {
                              double width = constraint.constrainWidth();
                              double height = constraint.constrainHeight();
                              return Container(
                                width: width,
                                height: height,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.h),
                                  ),
                                  color: Colors.white,
                                ),
                                alignment: Alignment.center,
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: SizedBox(
                                          width: width * 0.9,
                                          height: height * 0.58,
                                          child: _MoneyPart(
                                            centerColor: bgColors[index],
                                            imgPath: imgPaths[index],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: SizedBox(
                                          width: width * 0.9,
                                          height: height * 0.55,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  titles[index],
                                                  style: AppTS.normal,
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Text(
                                                  intros[index],
                                                  style: AppTS.small.copyWith(
                                                    letterSpacing: 2,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 45.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 5.h,
                              ),
                              ...List.generate(
                                colorList.length,
                                    (i) =>
                                    CircleAvatar(
                                      backgroundColor: colorList[i],
                                      radius: 10.h,
                                    ),
                              ),
                              SizedBox(
                                width: 5.h,
                              ),
                              GestureDetector(
                                child: Container(
                                  decoration: const ShapeDecoration(
                                    color: Colors.white,
                                    shape: CircleBorder(),
                                  ),
                                  padding: const EdgeInsets.all(2),
                                  child: Icon(
                                    Icons.check,
                                    color: bgColors[index],
                                    size: 20.h,
                                  ),
                                ),
                                onTap: () {
                                  MMKVUtil.put(AppString.mmColor, index);
                                  AppColors.changeColor(index);
                                  Get.offAllNamed(Routes.route);
                                },
                              ),
                              SizedBox(
                                width: 5.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _MoneyPart extends StatelessWidget {
  final Color centerColor;
  final String imgPath;

  const _MoneyPart({required this.centerColor, required this.imgPath, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            centerColor,
            Colors.white,
          ],
          center: Alignment.topCenter,
          radius: 0.78,
        ),
      ),
      alignment: Alignment.topCenter,
      child: Material(
        elevation: 10,
        child: Image.asset(imgPath),
      ),
    );
  }
}
