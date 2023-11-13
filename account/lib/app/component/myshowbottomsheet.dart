import 'package:flutter/material.dart';

import 'mydatepicker.dart';

void myShowBottomSheet(
    {required BuildContext context, required WidgetBuilder builder}) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      ),
    ),
    useSafeArea: true,
    elevation: 10,
    clipBehavior: Clip.antiAlias,
    context: context,
    builder: builder,
  );
}
