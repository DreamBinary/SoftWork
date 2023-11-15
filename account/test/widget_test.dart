import 'package:account/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mmkv/mmkv.dart';

void main() {

  setUpAll(() async {
    await MMKV.initialize();
  });

  testWidgets("description", (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
  });
}
