import 'dart:math';
import 'dart:ui';

import 'package:account/app/component/my_header/header_view.dart';
import 'package:account/app/component/mycard.dart';
import 'package:account/app/component/myshimmer.dart';
import 'package:account/app/component/mytopbar.dart';
import 'package:account/app/theme/app_text_theme.dart';
import 'package:account/app/utils/extension.dart';
import 'package:account/res/assets_res.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../component/multi_column_row.dart';
import '../../component/version_ctrl.dart';
import '../../data/net/api_consume.dart';
import '../../theme/app_colors.dart';
import '../../utils/date_util.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    // return const _SMorePage();

    return VersionCtrl
        .of(context)
        ?.version != 0
        ? const _SReportPage()
        : const _MReportPage();
  }
}

class _MReportPage extends StatelessWidget {
  const _MReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsRes.SUMMARY_BG),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyTopBar(
          middle: Text("总结报告", style: AppTS.normal),
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              blendMode: BlendMode.srcIn,
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 30),
                      const HeaderComponent(),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          "啊哈哈哈",
                          style: AppTS.normal,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: DottedLine(
                          lineLength: 250,
                          dashLength: 3,
                          lineThickness: 1,
                        ),
                      ),
                      Text(
                        "本月总收支概览",
                        style: AppTS.normal,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: MyCard(
                          Colors.white.withOpacity(0.7),
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: FutureBuilder(
                              future: getOutIn(),
                              builder: (_, snapshot) {
                                if (snapshot.hasData) {
                                  List<double> data =
                                  snapshot.data as List<double>;
                                  return MultiColumnRow(
                                    titles: const [
                                      "总收入",
                                      "总支出",
                                      "总余额",
                                    ],
                                    subTitles: [
                                      data[1].moneyFormat,
                                      data[0].moneyFormat,
                                      (max(data[1] - data[0], 0.0)).moneyFormat,
                                    ],
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    numTextStyle: AppTS.normal,
                                    decTextStyle: AppTS.big,
                                  );
                                } else {
                                  return ShimmerEffect(
                                    child: MultiColumnRow(
                                      titles: const [
                                        "总收入",
                                        "总支出",
                                        "总余额",
                                      ],
                                      subTitles: const [
                                        "0000",
                                        "0000",
                                        "0000",
                                      ],
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      numTextStyle: AppTS.normal,
                                      decTextStyle: AppTS.big,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: MyCard(
                              Colors.white.withOpacity(0.7),
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "本月最大\n一笔消费",
                                      style: AppTS.normal,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "100",
                                      style: AppTS.big,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: MyCard(
                              Colors.white.withOpacity(0.7),
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "本月存钱",
                                      style: AppTS.normal,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "200",
                                      style: AppTS.big,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      MyCard(
                        Colors.white.withOpacity(0.7),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "依据您的消费数据\n我们预计你下个月会花费",
                                style: AppTS.normal,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "732",
                                style: AppTS.big,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<double> _getOut() async {
    String date = DateUtil.getNowFormattedDate();
    return (await ApiConsume.getOut(type: "month", date: "$date 00:00:00"))
        ?.abs() ??
        0.0;
  }

  Future<double> _getIn() async {
    String date = DateUtil.getNowFormattedDate();
    return (await ApiConsume.getIn(type: "month", date: "$date 00:00:00"))
        ?.abs() ??
        0.0;
  }

  Future<List<double>> getOutIn() async {
    return Future.wait([_getOut(), _getIn()]);
  }
}

class _SReportPage extends StatelessWidget {
  const _SReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.color_list[1],
            AppColors.color_list[1],
            AppColors.color_list[1],
            AppColors.whiteBg,
            AppColors.whiteBg,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: MyTopBar(
            middle: Text("报告", style: AppTS.normal),
          ),
          body: Column(
            children: [
              const Spacer(flex: 3),
              MyCard(
                Colors.white,
                height: 100.h,
                child: Text(
                  "今日小结",
                  style: AppTS.big32,
                ),
              ),
              SizedBox(height: 15.h),
              MyCard(
                Colors.white,
                height: 100.h,
                child: Text(
                  "每月小结",
                  style: AppTS.big32,
                ),
              ),
              SizedBox(height: 15.h),
              MyCard(
                Colors.white,
                height: 100.h,
                child: Text(
                  "年度小结",
                  style: AppTS.big32,
                ),
              ),
              const Spacer(flex: 1),
            ],
          ).paddingSymmetric(horizontal: 20.w),
        ),
      ),
    );
  }
}
