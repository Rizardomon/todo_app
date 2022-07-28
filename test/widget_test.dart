import 'package:flutter_test/flutter_test.dart';

import 'package:todo_app_api/src/app.dart';

void main() {
  testWidgets(
    'Should render App without exceptions',
    (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      expect(tester.takeException(), null);
    },
  );
}
