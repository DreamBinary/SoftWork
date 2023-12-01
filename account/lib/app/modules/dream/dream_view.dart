import 'package:account/app/component/lines_text.dart';
import 'package:account/app/component/myelevatedbtn.dart';
import 'package:account/app/component/myshowbottomsheet.dart';
import 'package:account/app/component/mytopbarnormal.dart';
import 'package:account/app/theme/app_text_theme.dart';
import 'package:account/app/utils/date_util.dart';
import 'package:account/res/assets_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../component/mytopbar.dart';
import '../../data/entity/Goal.dart';
import '../../theme/app_colors.dart';
import 'dream_logic.dart';

class DreamPage extends StatefulWidget {
  const DreamPage({super.key});

  @override
  State<DreamPage> createState() => _DreamPageState();
}

class _DreamPageState extends State<DreamPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final logic = Get.find<DreamLogic>();
    final state = Get.find<DreamLogic>().state;
    final ctrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    late StateSetter aState;
    late StateSetter bState;
    return FutureBuilder(
      future: logic.init(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.color_list[1].withAlpha(0),
                    AppColors.color_list[1],
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const MyTopBarN(title: "梦想储蓄罐"),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () async {
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return SaveMoney(
                              onConfirm: (val) {
                                logic.saveMoney(val);
                              },
                            );
                          },
                        );
                        // todo
                        aState(() {});
                        bState(() {});
                        ctrl.forward(from: 0);
                      },
                      child: Transform.scale(
                        scale: 2,
                        child: Lottie.asset(
                          AssetsRes.COIN,
                          width: 75.w,
                          height: 75.w,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 300.w,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AssetsRes.BOTTLE),
                            fit: BoxFit.fill,
                          ),
                        ),
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 75.h),
                              child: Lottie.asset(
                                AssetsRes.COIN_DANCE,
                                controller: ctrl,
                              ),
                            ),
                            StatefulBuilder(
                              builder: (context, setState) {
                                aState = setState;
                                return Padding(
                                  padding: EdgeInsets.only(top: 75.h),
                                  child: CircularPercentIndicator(
                                    lineWidth: 15,
                                    circularStrokeCap: CircularStrokeCap.round,
                                    radius: 260.w / 3,
                                    animation: true,
                                    animateFromLastPercent: true,
                                    animationDuration: 1500,
                                    percent: logic.getSavedPercent(),
                                    backgroundColor: AppColors.color_list[0],
                                    progressColor: AppColors.color_list.last,
                                    center: state.goal == null
                                        ? LinesTextItem(
                                            texts: const ["还没有目标", ""],
                                            styles: [AppTS.normal, AppTS.small],
                                          )
                                        : LinesTextItem(
                                            texts: [
                                              "${(logic.getSavedPercent() * 100).floor()}%",
                                              "完成"
                                            ],
                                            styles: [AppTS.large, AppTS.small],
                                          ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    StatefulBuilder(
                      builder: (context, setState) {
                        bState = setState;
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: state.goal == null
                              ? Text(
                                  "还没有目标, 快去设定吧",
                                  style: AppTS.small,
                                )
                              : Text(
                                  "距离当前目标还有${logic.getGapMoneyPercent()}%, ${logic.getGapMoney()}元",
                                  style: AppTS.small,
                                ),
                        );
                      },
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        shape: const MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                          ),
                        ),
                        backgroundColor:
                            MaterialStatePropertyAll(AppColors.color_list.last),
                        fixedSize:
                            MaterialStatePropertyAll(Size.fromWidth(300.w)),
                      ),
                      onPressed: () async {
                        await myShowBottomSheet(
                          context: context,
                          builder: (context) {
                            return GoalContain(
                              goal: state.goal,
                              onCancel: () {
                                Navigator.pop(context);
                              },
                              onDelete: () async {
                                await logic.deleteGoal();
                                Get.back();
                              },
                              onConfirm: (goalName, date, money) async {
                                if (state.goal == null) {
                                  await logic.addGoal(goalName, date, money);
                                } else {
                                  await logic.updateGoal(goalName, date, money);
                                }
                                Get.back();
                              },
                            );
                          },
                        );
                        aState(() {});
                        bState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "设定目标",
                          style: AppTS.big.copyWith(
                            color: AppColors.textColor(
                              AppColors.color_list.last,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h)
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class SaveMoney extends StatefulWidget {
  final Function(int) onConfirm;

  const SaveMoney({required this.onConfirm, super.key});

  @override
  State<SaveMoney> createState() => _SaveMoneyState();
}

class _SaveMoneyState extends State<SaveMoney> {
  var moneyCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("存入金额", style: AppTS.normal),
      content: TextField(
        controller: moneyCtrl,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          hintText: "请输入金额",
          border: OutlineInputBorder(),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("取消", style: AppTS.normal),
        ),
        TextButton(
          onPressed: () {
            widget.onConfirm(int.parse(moneyCtrl.text));
            Navigator.pop(context);
          },
          child: Text("确定", style: AppTS.normal),
        ),
      ],
    );
  }
}

class GoalContain extends StatefulWidget {
  final Goal? goal;
  final VoidCallback? onCancel;
  final VoidCallback? onDelete;
  final Function(String, DateTime, num)? onConfirm;

  const GoalContain({
    this.goal,
    required this.onDelete,
    required this.onCancel,
    required this.onConfirm,
    super.key,
  });

  @override
  State<GoalContain> createState() => _GoalContainState();
}

class _GoalContainState extends State<GoalContain> {
  late final _nameCtrl = TextEditingController(text: widget.goal?.goalName);
  late final _moneyCtrl =
      TextEditingController(text: widget.goal?.money.toString());
  var date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.color_list[1].withAlpha(0),
            AppColors.color_list[1],
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Opacity(
                opacity: 0,
                child: MyBackButton(
                  color: Colors.white,
                ),
              ).paddingOnly(left: 10.w),
              Text(
                "设定目标",
                textAlign: TextAlign.center,
                style: AppTS.normal,
              ),
              Material(
                color: Colors.white,
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAlias,
                child: IconButton(
                  padding: const EdgeInsets.all(5),
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    widget.onDelete?.call();
                  },
                ),
              ).paddingOnly(right: 10.w),
            ],
          ),
          TextField(
            controller: _nameCtrl,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              hintText: "目标名称",
            ),
          ).paddingSymmetric(horizontal: 20.w),
          SizedBox(height: 20.h),
          TextField(
            controller: _moneyCtrl,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              hintText: "目标金额",
            ),
          ).paddingSymmetric(horizontal: 20.w),
          SizedBox(height: 20.h),
          GestureDetector(
            onTap: () async {
              var d = await showDatePicker(
                cancelText: "取消",
                confirmText: "选择",
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (d != null) {
                setState(() {
                  date = d;
                });
              }
            },
            child: Text(DateUtil.getFormattedDate(date), style: AppTS.normal),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MyElevatedBtn(
                color: AppColors.color_list.first,
                onPressed: () {
                  widget.onCancel?.call();
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "取消",
                    style: AppTS.normal.copyWith(
                      color: AppColors.textColor(AppColors.color_list.first),
                    ),
                  ),
                ),
              ),
              MyElevatedBtn(
                color: AppColors.color_list.last,
                onPressed: () {
                  widget.onConfirm?.call(
                    _nameCtrl.text,
                    date,
                    num.parse(_moneyCtrl.text),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "确定",
                    style: AppTS.normal.copyWith(
                      color: AppColors.textColor(AppColors.color_list.last),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
