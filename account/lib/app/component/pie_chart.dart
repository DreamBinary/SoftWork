import 'package:account/app/theme/app_colors.dart';
import 'package:account/app/theme/app_text_theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyPieChart extends StatefulWidget {
  final double radius;
  final List<double> percentage;
  final List<String> legend;

  const MyPieChart({required this.percentage,
    required this.radius,
    required this.legend,
    super.key});

  @override
  State<MyPieChart> createState() => MyPieChartState();
}

class MyPieChartState extends State<MyPieChart> {
  int touchedIndex = -1;

  late var pieRadius = 1.0;
  late final percentage = List.of(widget.percentage);
  late double initialFontSize = 0;

  late List<Color> colors = AppColors.randomColor(num: percentage.length);

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() {
      pieRadius += widget.radius;
      initialFontSize += 20;
    });
  }

  @override
  Widget build(BuildContext context) {
    percentage.sort();
    return SizedBox(
      width: widget.radius * 2.5,
      height: widget.radius * 2.5,
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(
            enabled: false,
            touchCallback: (FlTouchEvent event, pieTouchResponse) {
              setState(
                    () {
                  if (!event.isInterestedForInteractions ||
                      pieTouchResponse == null ||
                      pieTouchResponse.touchedSection == null) {
                    touchedIndex = -1;
                    return;
                  }
                  touchedIndex =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                },
              );
            },
          ),
          borderData: FlBorderData(

          ),
          sectionsSpace: 3,
          centerSpaceRadius: 0,
          sections: List.generate(
            percentage.length,
                (index) {
              final textColor = AppColors.textColor(colors[index]);
              final scale = (1 + percentage[index] * 0.5);
              final isTouched = index == touchedIndex;
              final TextStyle textStyle = isTouched
                  ? TextStyle(fontSize: ((initialFontSize + 4) * scale).sp,
                  color: textColor)
                  : TextStyle(
                  fontSize: (initialFontSize * scale).sp, color: textColor);
              final radius =
              (isTouched ? pieRadius * scale * 1.2 : pieRadius * scale)
                  .toDouble();
              return PieChartSectionData(
                value: percentage[index],
                color: colors[index],
                title: '${(percentage[index] * 100).toStringAsFixed(0)}%',
                radius: radius,
                titleStyle: textStyle,
                badgePositionPercentageOffset: 0.85,
                badgeWidget: isTouched
                    ? Container(
                  padding: const EdgeInsets.all(8),
                  decoration: ShapeDecoration(
                      color: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: Text(
                    widget.legend[index],
                    style: AppTS.big.copyWith(color: Colors.white),
                  ),
                )
                    : null,
              );
            },
          ),
        ),
        swapAnimationDuration: Duration(milliseconds: 500),
      ),
    );
  }
}
