import 'package:flutter/cupertino.dart';

class VersionCtrl extends InheritedWidget {
  const VersionCtrl({required this.version,
    required this.changeVersion,
    super.key,
    required super.child});

  final int version;
  final Function(int) changeVersion;

  static VersionCtrl? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<VersionCtrl>();
  }

  @override
  bool updateShouldNotify(VersionCtrl oldWidget) {
    return oldWidget.version != version;
  }
}
