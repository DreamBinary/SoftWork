import 'package:account/app/theme/app_text_theme.dart';
import 'package:account/app/utils/compute.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class MyBarChart extends StatefulWidget {
  final List<double> y;
  final List<String> x;

  const MyBarChart({required this.y, required this.x, super.key});

  @override
  State<StatefulWidget> createState() => MyBarChartState();
}

class MyBarChartState extends State<MyBarChart>
    with SingleTickerProviderStateMixin {
  int cnt = 0;
  late int len;
  late List<double> showYList;
  late List<Color> colors;
  int touchedGroupIndex = -1;
  late AnimationController ctrl = AnimationController(vsync: this);
  var touchedIndex = -1;
  late List<String> x;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    x = widget.x;
    len = widget.y.length;
    showYList = List.generate(len, (index) => 0);
    colors = AppColors.randomColor(num: len);
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() {
      for (int i = 0; i < len; i++) {
        showYList[i] += widget.y[i];
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
    return BarChart(
      BarChartData(
        maxY: MathUtil.max(widget.y),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.grey,
            tooltipPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            tooltipMargin: 8,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                showYList[groupIndex].toString(),
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              );
            },
          ),
          touchCallback: (FlTouchEvent event, barTouchResponse) {
            setState(() {
              if (!event.isInterestedForInteractions ||
                  barTouchResponse == null ||
                  barTouchResponse.spot == null) {
                touchedIndex = -1;
                return;
              }
              touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
            });
          },
          // touchCallback: (FlTouchEvent event, response) {
          //   if (response == null || response.spot == null) {
          //     setState(() {
          //       touchedGroupIndex = -1;
          //       showYList = List.of(yList);
          //       ctrl.reset();
          //     });
          //     return;
          //   }
          //
          //   touchedGroupIndex = response.spot!.touchedBarGroupIndex;
          //
          //   if (!event.isInterestedForInteractions) {
          //     touchedGroupIndex = -1;
          //     showYList = List.of(yList);
          //     return;
          //   }
          //   showYList[touchedGroupIndex] =
          //       ctrl.value * yList[touchedGroupIndex];
          //   if (ctrl.isAnimating) {
          //
          //   } else {
          //     ctrl.forward();
          //   }
          //
          //   if (touchedGroupIndex != -1) {
          //     showYList[touchedGroupIndex] = 0;
          //   }
          // },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: bottomTitles,
              reservedSize: 42,
            ),
          ),
          // leftTitles: AxisTitles(
          //   sideTitles: SideTitles(
          //     showTitles: true,
          //     reservedSize: 28,
          //     interval: 1,
          //     getTitlesWidget: leftTitles,
          //   ),
          // ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: List.generate(
          showYList.length,
          (index) {
            var isTouched = touchedIndex == index;
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: isTouched ? showYList[index] + 0.05 : showYList[index],
                  color: colors[index],
                  width: isTouched ? 9 : 7,
                  borderSide: BorderSide(
                    color: isTouched ? const Color(0xff3D3D3D) : Colors.grey,
                    width: 1,
                  ),
                )
              ],
            );
          },
        ),
        gridData: FlGridData(show: true, drawVerticalLine: false),
      ),
      swapAnimationDuration: Duration(seconds: 1),
    );
  } // @override

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '1K';
    } else if (value == 10) {
      text = '5K';
    } else if (value == 19) {
      text = '10K';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final Widget text = Text(
      x[value.toInt()],
      style: TextStyle(
        color: AppColors.color_list[5],
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }
}
