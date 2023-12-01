import 'package:flutter/material.dart';

class MyElevatedBtn extends StatelessWidget {
  final Color color;
  final VoidCallback? onPressed;
  final Widget child;

  const MyElevatedBtn({
    required this.color,
    required this.onPressed,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: const MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
          ),
        ),
        backgroundColor: MaterialStatePropertyAll(color),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        child: child,
      ),
    );
  }
}
