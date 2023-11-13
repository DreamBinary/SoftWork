import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class SelectChips extends StatefulWidget {
  final List<String> items;
  final Function(List<int>) onChanged;

  const SelectChips({required this.items, required this.onChanged, Key? key})
      : super(key: key);

  @override
  State<SelectChips> createState() => _SelectChipsState();
}

class _SelectChipsState extends State<SelectChips> {
  List<int> tags = [];

  @override
  Widget build(BuildContext context) {
    return ChipsChoice.multiple(
      wrapped: true,
      alignment: WrapAlignment.center,
      choiceStyle: C2ChipStyle.filled(
        selectedStyle: C2ChipStyle(
          backgroundColor: AppColors.color_list[5],
          borderRadius: BorderRadius.circular(10),
        ),
        disabledStyle: C2ChipStyle(
          backgroundColor: AppColors.color_list[0],
          borderRadius: BorderRadius.circular(10),
        ),
        color: AppColors.color_list[3].withOpacity(0.1),
      ),
      value: tags,
      onChanged: (value) {
        setState(() {
          tags = value;
        });
        widget.onChanged(value);
      },
      choiceItems: List.generate(
        widget.items.length,
        (index) =>
            C2Choice(value: index, label: widget.items[index], selected: false),
      ),
    );
  }
}
