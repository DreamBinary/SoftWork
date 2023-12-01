import 'package:flutter/material.dart';

Future<void> myShowBottomSheet(
    {required BuildContext context, required WidgetBuilder builder}) async {
  await showModalBottomSheet(
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      ),
    ),
    useSafeArea: true,
    elevation: 10,
    clipBehavior: Clip.antiAlias,
    context: context,
    builder: (context) => SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: builder(context),
      ),
    ),
  );
}
