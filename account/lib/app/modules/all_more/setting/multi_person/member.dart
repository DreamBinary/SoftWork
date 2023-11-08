import 'package:account/app/component/mytopbar.dart';
import 'package:account/app/data/entity/consume.dart';
import 'package:account/app/modules/all_more/setting/multi_person/invite_view.dart';
import 'package:account/app/modules/home/home_view.dart';
import 'package:account/app/theme/app_colors.dart';
import 'package:account/app/theme/app_text_theme.dart';
import 'package:account/res/assets_res.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatelessWidget {
  const MemberPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Color> colors = AppColors.randomColor(num: 4);
    return Scaffold(
      backgroundColor: AppColors.color_list[0],
      appBar: MyTopBar(
        backgroundColor: Colors.white,
        middle: Text('多人记账', style: AppTS.normal),
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
                      Text('4个',
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
                      SizedBox(height: 10.h),
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundImage: AssetImage(AssetsRes.P0),
                          backgroundColor: AppColors.whiteBg,
                        ),
                        title: Text('啊哈哈哈', style: AppTS.normal),
                        trailing: Text("账本主人",
                            style: AppTS.small
                                .copyWith(color: AppColors.color_list[5])),
                      ),
                      SizedBox(height: 10.h),
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundImage: AssetImage(AssetsRes.FATHER),
                          backgroundColor: AppColors.whiteBg,
                        ),
                        title: Text('爸爸', style: AppTS.normal),
                        trailing: Text("管理员",
                            style: AppTS.small
                                .copyWith(color: AppColors.color_list[4])),
                      ),
                      SizedBox(height: 10.h),
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundImage: AssetImage(AssetsRes.MOTHER),
                          backgroundColor: AppColors.whiteBg,
                        ),
                        title: Text('妈妈', style: AppTS.normal),
                        trailing: Text("管理员",
                            style: AppTS.small
                                .copyWith(color: AppColors.color_list[4])),
                      ),
                      SizedBox(height: 10.h),
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundImage: AssetImage(AssetsRes.GRANDFATHER),
                          backgroundColor: AppColors.whiteBg,
                        ),
                        title: Text('爷爷', style: AppTS.normal),
                        trailing: Text("游客",
                            style: AppTS.small
                                .copyWith(color: AppColors.color_list[4])),
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
                  child: Column(
                    children: [
                      DayRecord(
                        colorBg: Colors.white,
                        data: {
                          "2023.4.12": [
                            ConsumeData(
                              consumptionName: "客厅电视",
                              description: "啊哈哈哈",
                              amount: -2000,
                              typeId: 4,
                              store: "啊哈哈哈",
                              consumeTime: "00:00:00",
                              consumeDate: "2023-4-12",
                              credential: "",
                            ),
                            ConsumeData(
                              consumptionName: "工资",
                              description: "爸爸",
                              amount: 7000,
                              typeId: 15,
                              store: "爸爸",
                              consumeTime: "00:00:00",
                              consumeDate: "2023-4-12",
                              credential: "",
                            ),
                          ],
                        },
                      ),
                      DayRecord(
                        colorBg: Colors.white,
                        data: {
                          "2023.4.11": [
                            ConsumeData(
                              consumptionName: "今日食材",
                              description: "妈妈",
                              amount: -50,
                              typeId: 10,
                              store: "妈妈",
                              consumeTime: "00:00:00",
                              consumeDate: "2023.4.11",
                              credential: "",
                            ),
                            ConsumeData(
                              consumptionName: "水果",
                              description: "爷爷",
                              amount: -30,
                              typeId: 11,
                              store: "爷爷",
                              consumeTime: "00:00:00",
                              consumeDate: "2023.4.11",
                              credential: "",
                            ),
                          ],
                        },
                      ),
                    ],
                  ),
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
                MaterialButton(
                    onPressed: () {}, child: Text("批量管理", style: AppTS.normal)),
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
