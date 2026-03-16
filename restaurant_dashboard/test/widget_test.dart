import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_dashboard/app/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('App renders', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: App()));
    expect(find.text('Restaurant Dashboard'), findsOneWidget);
  });
}
