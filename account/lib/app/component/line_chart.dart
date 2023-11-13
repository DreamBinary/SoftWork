import 'package:account/app/data/entity/data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MyLineChart extends StatefulWidget {
  final Data data;

  const MyLineChart({required this.data, super.key});

  @override
  State<MyLineChart> createState() => _MyLineChartState();
}

class _MyLineChartState extends State<MyLineChart> {
  final List<FlSpot> spots = [];
  int cnt = 0;
  late int len = widget.data.len;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    while (cnt < len) {
      setState(() {
        spots.add(FlSpot(cnt.toDouble() + 1, widget.data.data[cnt]));
      });
      cnt++;
      // await Future.delayed(Duration(milliseconds: (exp(-cnt) * 1000).toInt()));
      await Future.delayed(Duration(milliseconds: (1 / cnt * 300).toInt()));
      // await Future.delayed(Duration(milliseconds: (log(cnt) * 50).toInt()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Colors.grey,
            tooltipPadding:
            const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            tooltipMargin: 16,
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                final flSpot = barSpot;
                return LineTooltipItem(
                  flSpot.y.toString(),
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                );
              }).toList();
            },
          ),
        ),
        gridData: FlGridData(
          show: false,
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
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: bottomTitleWidgets,
            ),
          ),
          // leftTitles: AxisTitles(
          //   sideTitles: SideTitles(
          //     showTitles: true,
          //     interval: 1,
          //     getTitlesWidget: leftTitleWidgets,
          //     reservedSize: 42,
          //   ),
          // ),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: len.toDouble() + 1,
        minY: widget.data.minY * 0.8,
        maxY: widget.data.maxY * 1.1,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            gradient: LinearGradient(
              colors: [
                AppColors.color_list[3],
                AppColors.color_list[4],
              ],
            ),
            barWidth: 1,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: false,
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  AppColors.color_list[1].withOpacity(0.5),
                  AppColors.color_list[2].withOpacity(0.5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 16,
    );
    Widget text;
    if (value.toInt() % 5 == 0 && value.toInt() != 0 ||
        value.toInt() == 1 ||
        value.toInt() == len) {
      text = Text(
        value.toInt().toString(),
        style: style,
      );
    } else {
      text = const Text(
        "",
        style: style,
      );
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 15,
    );
    String text;
    if (value.toInt() % 20 == 0) {
      text = value.toInt().toString();
    } else {
      return Container();
    }
    return Text(text, style: style, textAlign: TextAlign.left);
  }
}
