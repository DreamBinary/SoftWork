import 'package:account/app/component/myiconbtn.dart';
import 'package:account/app/modules/home/home_logic.dart';
import 'package:account/app/modules/home/home_view.dart';
import 'package:account/app/utils/mmkv.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mmkv/mmkv.dart';
import 'package:account/main.dart';
import 'package:get/get.dart';

void main() async {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    final rootDir = await MMKV.initialize();
    Get.put(HomeLogic());
    await tester.pumpWidget(const MHomePage());
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}

