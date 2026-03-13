import 'package:flutter_test/flutter_test.dart';
import 'package:customer_app/app/app.dart';

void main() {
  testWidgets('App renders', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    expect(find.text('Customer Home'), findsOneWidget);
  });
}
