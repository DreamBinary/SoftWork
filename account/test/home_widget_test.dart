import 'package:account/app/modules/home/home_logic.dart';
import 'package:account/app/modules/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mmkv/mmkv.dart';

void main() async {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    final rootDir = await MMKV.initialize();
    Get.put(HomeLogic());
    await tester.pumpWidget(const MHomePage());
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}

