import 'package:account/app/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../data/entity/consume.dart';
import '../routes/app_pages.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_theme.dart';
import 'lines_text.dart';
import 'mycard.dart';

class DayRecord extends StatefulWidget {
  final Color colorBg;
  final Map<String, List<ConsumeData>> data;
  final bool isOld;

  const DayRecord(
      {Key? key, required this.colorBg, required this.data, this.isOld = false})
      : super(key: key);

  @override
  State<DayRecord> createState() => _DayRecordState();
}

class _DayRecordState extends State<DayRecord> {
  @override
  Widget build(BuildContext context) {
    var time = widget.data.keys.first;
    var typeId = List.generate(widget.data.values.first.length,
        (i) => widget.data.values.first[i].typeId);
    var titles = List.generate(
      widget.data.values.first.length,
      (i) => widget.data.values.first[i].consumptionName,
    );
    var subTitles = List.generate(
      widget.data.values.first.length,
      (i) => widget.data.values.first[i].store,
    );
    var contents = List.generate(
      widget.data.values.first.length,
      (i) => widget.data.values.first[i].amount.toDouble().moneyFormatZero,
    );
    var colors = AppColors.randomColor(num: titles.length);
    return Container(
      color: widget.colorBg,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: widget.isOld
                ? BoxDecoration(
                    border: Border.all(
                        color: Colors.white,
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignOutside),
                    borderRadius: BorderRadius.circular(20),
                  )
                : null,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Chip(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                label: Text(
                  time,
                  style: AppTS.small
                      .copyWith(color: AppColors.textColor(colors[0])),
                ),
                backgroundColor: colors[0]),
          ),
          ...List.generate(
            titles.length,
            (index) {
              Color textColor = AppColors.textColor(colors[index]);
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Container(
                  decoration: widget.isOld
                      ? BoxDecoration(
                          border: Border.all(
                              color: Colors.white,
                              width: 2,
                              strokeAlign: BorderSide.strokeAlignOutside),
                          borderRadius: BorderRadius.circular(20),
                        )
                      : null,
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
                        arguments: widget.data.values.first[index],
                      );
                    },
                    child: Row(
                      children: [
                        SizedBox(width: 15.w),
                        if (!widget.isOld) ...[
                          CircleAvatar(
                            backgroundColor: AppColors.whiteBg,
                            child: Image.asset(
                              ConsumeData.paths[typeId[index]],
                              height: 25,
                              width: 25,
                            ),
                          ),
                          SizedBox(width: 15.w),
                        ],
                        Expanded(
                          child: LinesTextItem(
                            texts: widget.isOld
                                ? [titles[index]]
                                : [titles[index], subTitles[index]],
                            styles: widget.isOld
                                ? [
                                    AppTS.normal.copyWith(color: textColor),
                                  ]
                                : [
                                    AppTS.normal.copyWith(color: textColor),
                                    AppTS.small.copyWith(color: textColor)
                                  ],
                            textAlign: CrossAxisAlignment.start,
                            textColor: textColor,
                          ),
                        ),
                        Text(contents[index],
                            style: AppTS.normal.copyWith(color: textColor)),
                        SizedBox(width: 15.w),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
