import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_dashboard/app/app.dart';

void main() {
  testWidgets('App renders', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    expect(find.text('Restaurant Dashboard Home'), findsOneWidget);
  });
}
