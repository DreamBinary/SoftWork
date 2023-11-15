import 'package:account/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';


class MyDialog extends StatefulWidget {
  final String title;
  final Widget child;
  final double height;

  const MyDialog({
    super.key,
    required this.title,
    required this.child,
    this.height = 300,
  });

  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.whiteBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: widget.height,
        width: 250,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.title, style: AppTS.normal),
              const SizedBox(height: 10),
              Expanded(
                child: widget.child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
