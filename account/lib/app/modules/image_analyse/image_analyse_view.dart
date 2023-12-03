import 'dart:math';

import 'package:account/app/component/bar_chart.dart';
import 'package:account/app/component/lines_text.dart';
import 'package:account/app/component/mytopbar.dart';
import 'package:account/app/utils/extension.dart';
import 'package:account/res/assets_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../component/line_chart.dart';
import '../../component/multi_column_row.dart';
import '../../component/mydatepicker.dart';
import '../../component/myshimmer.dart';
import '../../component/myshowbottomsheet.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_theme.dart';
import '../../utils/date_util.dart';
import 'image_analyse_logic.dart';

class ImageAnalysePage extends StatefulWidget {
  const ImageAnalysePage({super.key});

  @override
  State<ImageAnalysePage> createState() => _ImageAnalysePageState();
}

class _ImageAnalysePageState extends State<ImageAnalysePage> {
  final logic = Get.find<ImageAnalyseLogic>();
  final state = Get.find<ImageAnalyseLogic>().state;
  late String date = state.date ?? DateUtil.getNowFormattedDate();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: MyTopBar(
        middle: GestureDetector(
          onTap: () {
            myShowBottomSheet(
              context: context,
              builder: (context) {
                return MyDatePicker(
                  isSingleMonth: true,
                  changeTime: (start_, end_, isMonth_) {
                    logic.clear();
                    setState(
                      () {
                        date = "$start_-01";
                      },
                    );
                  },
                );
              },
            );
          },
          child: Text(
            "${date.split("-")[0]}年${date.split("-")[1]}月\n图像分析报告",
            style: AppTS.normal,
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: AppColors.color_list[1],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 420.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.color_list[1],
                    AppColors.color_list[2],
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: _PiePart(date: date),
            ),
            // Text("类型占比柱状图", style: AppTS.small)
            //     .paddingSymmetric(vertical: 15.h, horizontal: 20.w),
            // Container(
            //     height: 200.h,
            //     padding: EdgeInsets.only(right: 15.w),
            //     child: FutureBuilder(
            //         future: logic.getTypeAll(date),
            //         builder: (context, snapshot) {
            //           if (snapshot.hasData) {
            //             List<double> percentage =
            //                 snapshot.data!.map((e) => e.values.first).toList();
            //             List<String> type =
            //                 snapshot.data!.map((e) => e.keys.first).toList();
            //             if (percentage.isNotEmpty) {
            //               return MyBarChart(y: percentage, x: type);
            //             } else {
            //               return Container(
            //                 alignment: Alignment.center,
            //                 child: Text(
            //                   "无记录",
            //                   style: AppTS.small,
            //                 ),
            //               );
            //             }
            //           } else {
            //             return Center(
            //               child: ShimmerEffect(
            //                 child: Container(
            //                   width: 300.h,
            //                   height: 175.h,
            //                   decoration: BoxDecoration(
            //                     color: AppColors.color_list[1].withAlpha(150),
            //                     image: const DecorationImage(
            //                       image: AssetImage(AssetsRes.COVER_LINE),
            //                       fit: BoxFit.cover,
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             );
            //           }
            //         })),
            Text("收支记录折线图", style: AppTS.small)
                .paddingSymmetric(vertical: 15.h, horizontal: 20.w),
            Container(
              color: AppColors.whiteBg,
              height: 250.h,
              padding: EdgeInsets.only(right: 15.w),
              child: FutureBuilder(
                // future: Future.delayed(const Duration(seconds: 5), () {
                //   return data;
                // }),
                future: logic.getThirtyOutList(date),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return MyLineChart(data: snapshot.data!);
                  } else {
                    return Center(
                      child: ShimmerEffect(
                        child: Container(
                          width: 300.h,
                          height: 175.h,
                          decoration: BoxDecoration(
                            color: AppColors.color_list[1].withAlpha(150),
                            image: const DecorationImage(
                              image: AssetImage(AssetsRes.COVER_LINE),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}

class _PiePart extends StatefulWidget {
  final String date;

  const _PiePart({required this.date, Key? key}) : super(key: key);

  @override
  State<_PiePart> createState() => _PiePartState();
}

class _PiePartState extends State<_PiePart> {
  final logic = Get.find<ImageAnalyseLogic>();
  final state = Get.find<ImageAnalyseLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FutureBuilder(
          future: logic.getTypeTop4(widget.date),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<double> percentage =
                  snapshot.data!.map((e) => e.values.first).toList();
              List<String> type =
                  snapshot.data!.map((e) => e.keys.first).toList();
              return SizedBox(
                height: 280,
                child: BubbleChart(
                  percentages: percentage,
                  types: type,
                ),
              );
            } else {
              return Center(
                child: ShimmerEffect(
                  child: Container(
                    width: 300.h,
                    height: 175.h,
                    decoration: BoxDecoration(
                      color: AppColors.color_list[1].withAlpha(150),
                      image: const DecorationImage(
                        image: AssetImage(AssetsRes.COVER_LINE),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),
        FutureBuilder(
          future: logic.getOutIn(date: widget.date),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<double> outIn = snapshot.data as List<double>;
              return MultiColumnRow(
                subTitles: const [
                  "总支出",
                  "总收入",
                  "总余额",
                ],
                titles: [
                  outIn[0].moneyFormat,
                  outIn[1].moneyFormat,
                  (max(outIn[1] - outIn[0], 0.0)).moneyFormat,
                ],
                hasDivider: true,
                crossAxisAlignment: CrossAxisAlignment.center,
              ).paddingSymmetric(horizontal: 30.w);
            } else {
              return Center(
                child: ShimmerEffect(
                  child: const MultiColumnRow(
                    subTitles: [
                      "总支出",
                      "总收入",
                      "总余额",
                    ],
                    titles: [
                      "0000",
                      "0000",
                      "0000",
                    ],
                    hasDivider: true,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ).paddingSymmetric(horizontal: 30.w),
                ),
              );
            }
          },
        ),
        Container(
          width: 300.w,
          height: 70.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  "距离心愿攒满还有",
                  style: AppTS.small,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: LinearPercentIndicator(
                      animation: true,
                      // percent: income / (expend + income),
                      percent: 0.7,
                      backgroundColor: AppColors.color_list[3],
                      progressColor: AppColors.color_list[5],
                      lineHeight: 10.h,
                      barRadius: Radius.circular(5.h),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  LinesTextItem(
                      texts: ["20%", "800元"],
                      styles: [AppTS.small, AppTS.minor]),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

class BubbleChart extends StatefulWidget {
  final List<String> types;
  final List<double> percentages;

  const BubbleChart({required this.types, required this.percentages, Key? key})
      : super(key: key);

  @override
  State<BubbleChart> createState() => _BubbleChartState();
}

class _BubbleChartState extends State<BubbleChart> {
  late double width;
  late double height;
  late int len;
  late List<Color> colors;
  late List<double> showPer;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    len = widget.percentages.length;
    colors = AppColors.randomColor(num: len);
    showPer = List.generate(len, (index) => 0);
    await Future.delayed(const Duration(milliseconds: 10));
    setState(() {
      for (int i = 0; i < len; i++) {
        showPer[i] += widget.percentages[i];
      }
    });
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    init();
  }

  @override
  Widget build(BuildContext context) {
    double rHeight = 300;
    double mHeight = 75;
    double mmHeight = 180;
    return LayoutBuilder(
      builder: (context, constraint) {
        width = constraint.constrainWidth();
        height = constraint.constrainHeight();
        return Stack(
          clipBehavior: Clip.none,
          children: len == 1
              ? [
                  Center(
                    child: Bubble(
                      percentage: showPer[0],
                      type: widget.types[0],
                      color: colors[0],
                      height: min(max(rHeight * showPer[0], mHeight), mmHeight),
                    ),
                  )
                ]
              : List.generate(
                  len,
                  (index) => getPosition(
                    index,
                    Bubble(
                      percentage: showPer[index],
                      type: widget.types[index],
                      color: colors[index],
                      height:
                          min(max(rHeight * showPer[index], mHeight), mmHeight),
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget getPosition(int index, Widget child) {
    switch (index) {
      case 1:
        return Positioned(
          left: width * 0.2,
          top: height * 0.2,
          child: child,
        );
      case 2:
        return Positioned(
          left: width * 0.15,
          top: height * 0.55,
          child: child,
        );
      case 3:
        return Positioned(
          left: width * 0.7,
          top: height * 0.15,
          child: child,
        );
      case 0:
        return Positioned(
          left: width * 0.4,
          top: height * 0.4,
          child: child,
        );
      case 4:
        return Positioned(
          left: width * 0.45,
          top: height * 0.05,
          child: child,
        );
    }
    return Positioned(
      left: width * 0.4,
      top: height * 0.4,
      child: child,
    );
  }
}

class Bubble extends StatefulWidget {
  final String type;
  final double percentage;
  final Color color;
  final double height;

  const Bubble(
      {required this.type,
      required this.percentage,
      required this.height,
      required this.color,
      Key? key})
      : super(key: key);

  @override
  State<Bubble> createState() => _BubbleState();
}

class _BubbleState extends State<Bubble> with TickerProviderStateMixin {
  late final AnimationController _ctrl =
      AnimationController(vsync: this, duration: const Duration(seconds: 1))
        ..forward();

  @override
  Widget build(BuildContext context) {
    var fontsize = max(widget.percentage * 40.sp, 16.sp);
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) {
        return Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(widget.height * 0.45),
          child: Container(
            height: widget.height * _ctrl.value,
            width: widget.height * _ctrl.value,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    widget.color.withOpacity(0.4),
                    widget.color.withOpacity(0.6),
                    widget.color.withOpacity(0.8),
                    widget.color
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  tileMode: TileMode.clamp),
              borderRadius: BorderRadius.circular(widget.height * 0.45),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.type,
                  style: TextStyle(
                      color: AppColors.textColor(widget.color),
                      fontSize: fontsize * _ctrl.value),
                ),
                Text(
                  "${(widget.percentage * 100).toStringAsFixed(0)}%",
                  style: TextStyle(
                      color: AppColors.textColor(widget.color),
                      fontSize: fontsize * _ctrl.value),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
