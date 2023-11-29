import 'package:account/app/component/multi_column_row.dart';
import 'package:account/app/component/mybottombar.dart';
import 'package:account/app/component/myshimmer.dart';
import 'package:account/app/routes/app_pages.dart';
import 'package:account/app/theme/app_colors.dart';
import 'package:account/app/theme/app_text_theme.dart';
import 'package:account/app/utils/extension.dart';
import 'package:account/res/assets_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../component/mytopbar.dart';
import 'analyse_logic.dart';

class AnalysePage extends StatelessWidget {
  const AnalysePage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<AnalyseLogic>();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.color_list[1], Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyTopBar(
          middle: Text("收支分析", style: AppTS.big),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _ProportionCard(),
            FutureBuilder(
                future: logic.getOut(),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    return _IETextRow(
                      budget: 5231,
                      expend: snapshot.data!,
                      remain: 1599,
                    );
                  } else {
                    return const _IETextRow(
                      budget: 0000,
                      expend: 0000,
                      remain: 0000,
                    );
                  }
                }),
            _IEBtnRow(),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 30.w),
                child: Text(
                  "生成分析报告",
                  style: AppTS.big,
                ),
              ),
            ),
            _AnalyseCard(
              title: "图像分析报告",
              color: AppColors.color_list[3],
              imgPath: AssetsRes.IMAGE_ANALYSE,
              onPressed: () {
                Get.toNamed(Routes.imageAnalyse);
              },
            ),
            _AnalyseCard(
              title: "表格详细报告",
              color: AppColors.color_list[2],
              imgPath: AssetsRes.TABLE_ANALYSE,
              // todo
              // imgColor: AppColors.color_list[2],
              onPressed: () {
                Get.toNamed(Routes.tableAnalyse);
              },
            ),
          ],
        ),
        bottomNavigationBar: const MyBottomBarPlaceholder(),
      ),
    );
  }
}

class _ProportionCard extends StatelessWidget {
  _ProportionCard({Key? key}) : super(key: key);
  final colors = AppColors.randomColor(num: 4);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      height: 120.h,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomPaint(
            size: Size(double.maxFinite, 40.h),
            painter: _LinePainter(
              proportion: [0.4, 0.3, 0.2, 0.1],
              colors: colors,
            ),
          ),
          _ColorLegendRow(
            colors: colors.reversed.toList(),
            labels: const ["伙食", "房租", "水电", "剩余"],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: SizedBox(
                height: 30.h,
                child: MaterialButton(
                  onPressed: () {
                    Get.toNamed(Routes.budget);
                  },
                  shape: const StadiumBorder(),
                  child: Text("点击查看详情 >", style: AppTS.minor),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ColorLegendRow extends StatelessWidget {
  final List<Color> colors;
  final List<String> labels;

  const _ColorLegendRow({required this.colors, required this.labels, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        colors.length,
        (index) => _ColorLegend(
          color: colors[index],
          label: labels[index],
        ),
      ),
    );
  }
}

class _ColorLegend extends StatelessWidget {
  final Color color;
  final String label;

  const _ColorLegend({required this.color, required this.label, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 10.w,
          width: 10.w,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 10),
        Text(label, style: AppTS.small)
      ],
    );
  }
}

class _LinePainter extends CustomPainter {
  final List<double> proportion;
  final List<Color> colors;

  _LinePainter({required this.proportion, required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    proportion.sort((a, b) => a.compareTo(b));
    var paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 10.h
      ..strokeCap = StrokeCap.round;
    double maxWidth = size.width * 0.8;
    double start = size.width - (size.width - maxWidth) / 2;
    double len = 0;
    int l = proportion.length;
    for (var i = 0; i < l; i++) {
      len = proportion[i] * maxWidth;
      paint.color = colors[i];
      canvas.drawLine(Offset(start, size.height * 0.6),
          Offset(start - len, size.height * 0.6), paint);
      start -= len;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _AnalyseCard extends StatelessWidget {
  final String title;
  final Color color;
  final String imgPath;
  final VoidCallback? onPressed;

  const _AnalyseCard(
      {required this.title,
      required this.color,
      required this.imgPath,
      this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: MaterialButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        color: color,
        elevation: 10,
        onPressed: onPressed,
        child: Container(
          height: 90.h,
          width: double.maxFinite,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            children: [
              Text(title,
                  style:
                      AppTS.normal.copyWith(color: AppColors.textColor(color))),
              const Spacer(),
              Image.asset(imgPath),
            ],
          ),
        ),
      ),
    );
  }
}

class _IETextRow extends StatelessWidget {
  final double budget;
  final double expend;
  final double remain;

  const _IETextRow(
      {required this.budget,
      required this.expend,
      required this.remain,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titles = [budget.moneyFormat, expend.moneyFormat, remain.moneyFormat];
    final subTitles = ["本月总预算", "本月支出", "总余额"];
    return MultiColumnRow(titles: titles, subTitles: subTitles);
  }
}

class _IEBtnRow extends StatelessWidget {
  final logic = Get.find<AnalyseLogic>();

  _IEBtnRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            const SizedBox(width: 30),
            _IEBtn(
              flagColor: AppColors.color_list[5],
              onPressed: () {},
              child: FutureBuilder(
                future: logic.getOutIn(),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    return _IEBtnText(
                      title: "本月收支",
                      income: snapshot.data![1],
                      expend: snapshot.data![0],
                    );
                  } else {
                    return const ShimmerEffect(
                      child: _IEBtnText(
                        title: "本月收支",
                        income: 0000,
                        expend: 0000,
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(width: 30),
            _IEBtn(
              flagColor: AppColors.color_list[4],
              onPressed: () {},
              child: FutureBuilder(
                future: logic.getOutIn(isLastMonth: true),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    return _IEBtnText(
                      title: "上月收支",
                      income: snapshot.data![1],
                      expend: snapshot.data![0],
                    );
                  } else {
                    return const ShimmerEffect(
                      child: _IEBtnText(
                        title: "上月收支",
                        income: 0000,
                        expend: 0000,
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(width: 30),
            _IEBtn(
              flagColor: AppColors.color_list[2],
              onPressed: () {},
              child: const _IEBtnText(
                title: "历史收支",
              ),
            ),
            const SizedBox(width: 30),
          ],
        ),
      ),
    );
  }
}

class _IEBtnText extends StatelessWidget {
  final String title;
  final double? income;
  final double? expend;

  const _IEBtnText({required this.title, this.income, this.expend, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: AppTS.normal,
        ),
        if (income != null) ...[
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "收入 ${income?.truncate()}",
                style: AppTS.minor,
              ),
              const SizedBox(width: 5),
              Text(
                "支出 ${expend?.truncate()}",
                style: AppTS.minor,
              )
            ],
          )
        ]
      ],
    );
  }
}

class _IEBtn extends StatelessWidget {
  final Widget? child;
  final VoidCallback? onPressed;
  final Color? flagColor;

  const _IEBtn({this.child, this.onPressed, this.flagColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 80.h,
        width: 130.w,
        child: RawMaterialButton(
          fillColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          onPressed: onPressed,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: double.maxFinite,
                  width: 5.w,
                  color: flagColor,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: child,
              )
            ],
          ),
        ),
      ),
    );
  }
}
