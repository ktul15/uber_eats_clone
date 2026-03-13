import 'package:flutter_test/flutter_test.dart';
import 'package:driver_app/app/app.dart';

void main() {
  testWidgets('App renders', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    expect(find.text('Driver App Home'), findsOneWidget);
  });
}
