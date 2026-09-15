import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_dashboard/features/menu/presentation/screens/home_dashboard_screen.dart';

void main() {
  testWidgets('restaurant creation validates required fields and coordinates', (
    tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(child: RestaurantCreationForm()),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Create restaurant'));
    await tester.pump();

    expect(find.text('Name is required'), findsOneWidget);
    expect(find.text('Address is required'), findsOneWidget);
    expect(find.text('Enter a value from -90 to 90'), findsOneWidget);
    expect(find.text('Enter a value from -180 to 180'), findsOneWidget);
  });
}
