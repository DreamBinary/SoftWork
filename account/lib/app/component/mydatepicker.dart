import 'package:account/app/theme/app_colors.dart';
import 'package:account/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../utils/date_util.dart';

class MyDatePicker extends StatefulWidget {
  final bool isSingleMonth;
  final bool isSingleDay;
  final Function(String, String, bool) changeTime;

  const MyDatePicker(
      {this.isSingleDay = false,
      this.isSingleMonth = false,
      required this.changeTime,
      Key? key})
      : super(key: key);

  @override
  State<MyDatePicker> createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  late bool isMonth;
  String? startTime;
  String? endTime;

  @override
  void initState() {
    super.initState();
    assert(!(widget.isSingleDay && widget.isSingleMonth));
    if (widget.isSingleMonth) {
      isMonth = true;
    } else {
      isMonth = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!widget.isSingleMonth && !widget.isSingleDay)
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: MaterialButton(
                onPressed: () {
                  setState(() {
                    isMonth = !isMonth;
                  });
                },
                visualDensity: VisualDensity.compact,
                shape: const StadiumBorder(),
                child: Text(
                  isMonth ? "选择日期" : "选择月份",
                  style: AppTS.small,
                ),
              ),
            ),
          ),
        Expanded(
          child: isMonth
              ? MonthPicker(
                  onTimeChanged: (value) {
                    startTime = value;
                    endTime = value;
                  },
                )
              : DatePicker(
                  isSingleDay: widget.isSingleDay,
                  onStarTimeChanged: (value) {
                    startTime = value;
                  },
                  onEndTimeChanged: (value) {
                    endTime = value;
                  },
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MaterialButton(
              shape: const StadiumBorder(),
              onPressed: () {
                Get.back();
              },
              child: Text(
                "取消",
                style: AppTS.small,
              ),
            ),
            MaterialButton(
              shape: const StadiumBorder(),
              onPressed: () {
                // isMonth
                //     ? widget.changeTime("$startTime-01 00:00:00", "$startTime-01 00:00:00")
                //     : widget.changeTime("$startTime 00:00:00", "$endTime 00:00:00");
                if (startTime == null) {
                  if (isMonth) {
                    startTime = "2023-01";
                    endTime = startTime;
                  } else {
                    startTime = DateUtil.getNowFormattedDate();
                    endTime = startTime;
                  }
                }
                widget.changeTime(startTime!, endTime!, isMonth);
                Get.back();
              },
              child: Text(
                "确定",
                style: AppTS.small,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class DatePicker extends StatelessWidget {
  const DatePicker(
      {required this.onStarTimeChanged,
      required this.onEndTimeChanged,
      required this.isSingleDay,
      Key? key})
      : super(key: key);
  final bool isSingleDay;
  final ValueChanged<String> onStarTimeChanged;
  final ValueChanged<String> onEndTimeChanged;

  @override
  Widget build(BuildContext context) {
    Color selectedColor = AppColors.color_list[2];
    Color rangeColor = AppColors.color_list[0];
    return SfDateRangePicker(
      headerStyle: DateRangePickerHeaderStyle(
        textAlign: TextAlign.center,
        textStyle: AppTS.normal,
      ),
      headerHeight: 40.h,
      selectionMode: isSingleDay
          ? DateRangePickerSelectionMode.single
          : DateRangePickerSelectionMode.range,
      todayHighlightColor: AppColors.color_list[5],
      selectionColor: selectedColor,
      rangeSelectionColor: rangeColor,
      startRangeSelectionColor: selectedColor,
      endRangeSelectionColor: selectedColor,
      showNavigationArrow: false,
      monthViewSettings: const DateRangePickerMonthViewSettings(
        dayFormat: "EEE",
        showTrailingAndLeadingDates: true,
      ),
      onSelectionChanged: (value) {
        var date = value.value;
        if (date == null) {
          return;
        }
        if (date.runtimeType == PickerDateRange) {
          final DateTime rangeStartDate = date.startDate!;
          final DateTime rangeEndDate =
              date.endDate == null ? date.startDate! : date.endDate!;
          onStarTimeChanged(
              "${rangeStartDate.year}-${rangeStartDate.month.toString().padLeft(2, "0")}-${rangeStartDate.day.toString().padLeft(2, "0")}");
          onEndTimeChanged(
              "${rangeEndDate.year}-${rangeEndDate.month.toString().padLeft(2, "0")}-${rangeEndDate.day.toString().padLeft(2, "0")}");
        } else if (date.runtimeType == DateTime) {
          onStarTimeChanged(
            date.toString().split(" ")[0],
          );
          onEndTimeChanged(
            date.toString().split(" ")[0],
          );
        }
      },
    );
  }
}

class MonthPicker extends StatefulWidget {
  final ValueChanged<String> onTimeChanged;

  const MonthPicker({required this.onTimeChanged, Key? key}) : super(key: key);

  @override
  State<MonthPicker> createState() => _MonthPickerState();
}

class _MonthPickerState extends State<MonthPicker> {
  final months = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
  var month = 1;
  var year = 2023;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ScrollNum(
            nums: List.generate(200, (index) => index + 1923),
            initialItem: 100,
            onSelectedItemChanged: (index) {
              year = index + 1923;
              widget.onTimeChanged(
                  "$year-${month.toString().toString().padLeft(2, "0")}");
            },
          ),
          Text(
            "年",
            style: AppTS.big,
          ),
          _ScrollNum(
            nums: months,
            onSelectedItemChanged: (index) {
              month = index + 1;
              widget.onTimeChanged(
                  "$year-${month.toString().toString().padLeft(2, "0")}");
            },
          ),
          Text(
            "月",
            style: AppTS.big,
          )
        ],
      ),
    );
  }
}

class _ScrollNum extends StatelessWidget {
  final List<int> nums;
  final ValueChanged<int>? onSelectedItemChanged;
  final int initialItem;

  const _ScrollNum(
      {required this.nums,
      this.onSelectedItemChanged,
      this.initialItem = 0,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 150,
      alignment: Alignment.center,
      child: ListWheelScrollView(
        controller: FixedExtentScrollController(initialItem: initialItem),
        itemExtent: 50,
        physics: const FixedExtentScrollPhysics(),
        useMagnifier: true,
        magnification: 1.2,
        overAndUnderCenterOpacity: 0.5,
        onSelectedItemChanged: onSelectedItemChanged,
        children: List.generate(
          nums.length,
          (index) => Container(
            height: 50,
            width: 100,
            alignment: Alignment.center,
            child: Text(
              nums[index].toString().padLeft(2, "0"),
              style: AppTS.big,
            ),
          ),
        ),
      ),
    );
  }
}
