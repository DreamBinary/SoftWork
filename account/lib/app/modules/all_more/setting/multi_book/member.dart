import 'package:account/app/component/mytopbar.dart';
import 'package:account/app/data/entity/consume.dart';
import 'package:account/app/data/net/api_multi.dart';
import 'package:account/app/modules/all_more/setting/multi_book/invite_view.dart';
import 'package:account/app/theme/app_colors.dart';
import 'package:account/app/theme/app_text_theme.dart';
import 'package:account/res/assets_res.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../component/dayrecord.dart';

class MemberPage extends StatefulWidget {
  final num multiLedgerId;

  const MemberPage({required this.multiLedgerId, Key? key}) : super(key: key);

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  late List<String> usernames;

  final avatar = [
    AssetsRes.P0,
    AssetsRes.GRANDFATHER,
    AssetsRes.FATHER,
    AssetsRes.MOTHER
  ];

  @override
  void initState() {
    super.initState();
    usernames = Get.arguments as List<String>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color_list[0],
      appBar: MyTopBar(
        backgroundColor: Colors.white,
        middle: Text('多人账本', style: AppTS.normal),
      ),
      body: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 55.h,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('角色管理', style: AppTS.normal),
                      Text('${usernames.length}个',
                          style: AppTS.small.copyWith(color: Colors.grey)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text("成员管理（共4 个）", style: AppTS.small),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      ...List.generate(
                        usernames.length,
                        (index) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(avatar[index % 4]),
                            backgroundColor: AppColors.whiteBg,
                          ),
                          title: Text(usernames[index], style: AppTS.normal),
                        ).paddingSymmetric(vertical: 5.h),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text("收支记录", style: AppTS.small),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: FutureBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data
                            as List<Map<String, List<ConsumeData>>>;
                        return Column(
                          children: [
                            ...List.generate(
                              data.length,
                              (index) => DayRecord(
                                colorBg: Colors.white,
                                data: data[index],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Center(
                          child: Text("还没有记录", style: AppTS.normal)
                              .paddingSymmetric(vertical: 150.h),
                        );
                      }
                    },
                    future:
                        ApiMultiBook.getMultiBookRecord(widget.multiLedgerId),
                  ),

                  // Column(
                  //   children: [
                  //     DayRecord(
                  //       colorBg: Colors.white,
                  //       data: {
                  //         "2023.4.12": [
                  //           ConsumeData(
                  //             consumptionName: "客厅电视",
                  //             description: "啊哈哈哈",
                  //             amount: -2000,
                  //             typeId: 4,
                  //             store: "啊哈哈哈",
                  //             consumeTime: "00:00:00",
                  //             consumeDate: "2023-4-12",
                  //             credential: "",
                  //           ),
                  //           ConsumeData(
                  //             consumptionName: "工资",
                  //             description: "爸爸",
                  //             amount: 7000,
                  //             typeId: 15,
                  //             store: "爸爸",
                  //             consumeTime: "00:00:00",
                  //             consumeDate: "2023-4-12",
                  //             credential: "",
                  //           ),
                  //         ],
                  //       },
                  //     ),
                  //     DayRecord(
                  //       colorBg: Colors.white,
                  //       data: {
                  //         "2023.4.11": [
                  //           ConsumeData(
                  //             consumptionName: "今日食材",
                  //             description: "妈妈",
                  //             amount: -50,
                  //             typeId: 10,
                  //             store: "妈妈",
                  //             consumeTime: "00:00:00",
                  //             consumeDate: "2023.4.11",
                  //             credential: "",
                  //           ),
                  //           ConsumeData(
                  //             consumptionName: "水果",
                  //             description: "爷爷",
                  //             amount: -30,
                  //             typeId: 11,
                  //             store: "爷爷",
                  //             consumeTime: "00:00:00",
                  //             consumeDate: "2023.4.11",
                  //             credential: "",
                  //           ),
                  //         ],
                  //       },
                  //     ),
                  //   ],
                  // ),
                )
              ],
            ),
          )),
          Container(
            color: Colors.white,
            height: 70.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // getMultiBookBalance
                FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        "结余: ${snapshot.data?.toStringAsFixed(2)}",
                        style: AppTS.normal,
                      );
                    } else {
                      return Text("结余: 0.00", style: AppTS.normal);
                    }
                  },
                  future:
                      ApiMultiBook.getMultiBookBalance(widget.multiLedgerId),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: OpenContainer(
                      closedShape: const StadiumBorder(),
                      closedElevation: 0,
                      closedBuilder: (
                        context,
                        action,
                      ) {
                        return Container(
                          color: AppColors.color_list[1],
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 60, vertical: 10),
                            child: Text("邀请成员", style: AppTS.normal),
                          ),
                        );
                      },
                      openBuilder: (
                        context,
                        action,
                      ) {
                        return const InvitePage();
                      }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
