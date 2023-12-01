import 'package:account/app/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../component/lines_text.dart';
import '../../component/mycard.dart';
import '../../component/mytopbar.dart';
import '../../data/entity/consume.dart';
import '../../routes/app_pages.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_theme.dart';
import 'record_logic.dart';

class RecordPage extends StatefulWidget {
  // List<Map<String, List<ConsumeData>>> data = [];

  const RecordPage({Key? key}) : super(key: key);

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  late List<ConsumeData> data;
  late int len;
  late List<Color> colors;

  @override
  void initState() {
    super.initState();
    final logic = Get.find<RecordLogic>();
    final state = Get.find<RecordLogic>().state;
    data = Get.arguments;
    len = data.length;
    colors = AppColors.randomColor(num: len);
  }

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<RecordLogic>();
    final state = Get.find<RecordLogic>().state;
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: MyTopBar(
        middle: Text("记录详情", style: AppTS.normal),
      ),
      body: ListView(
        children: List.generate(
          len,
          (index) {
            Color textColor = AppColors.textColor(colors[index]);
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: MyCard(
                colors[index],
                height: 80.h,
                elevation: 8,
                showBadge: true,
                onBadgeTap: () {
                  // todo
                  // delete
                },
                onPressed: () {
                  Get.toNamed(
                    Routes.add,
                    arguments: data[index],
                  );
                },
                child: Row(
                  children: [
                    SizedBox(width: 15.w),
                    CircleAvatar(
                      backgroundColor: AppColors.whiteBg,
                      child: Image.asset(
                        ConsumeData.paths[data[index].typeId],
                        height: 25,
                        width: 25,
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: LinesTextItem(
                        texts: [
                          data[index].consumptionName,
                          data[index].store
                        ],
                        styles: [
                          AppTS.normal.copyWith(color: textColor),
                          AppTS.small.copyWith(color: textColor)
                        ],
                        textAlign: CrossAxisAlignment.start,
                        textColor: textColor,
                      ),
                    ),
                    Text(
                      data[index].amount.toDouble().moneyFormatZero,
                      style: AppTS.normal.copyWith(color: textColor),
                    ),
                    SizedBox(width: 15.w),
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
