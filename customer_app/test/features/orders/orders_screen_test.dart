import 'dart:async';

import 'package:customer_app/features/orders/data/data_sources/order_api_client.dart';
import 'package:customer_app/features/orders/data/models/order_dto.dart';
import 'package:customer_app/features/orders/presentation/screens/orders_screen.dart';
import 'package:customer_app/features/orders/providers/order_providers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('only delivered unreviewed orders show Rate Order', (
    tester,
  ) async {
    await _pumpOrders(tester, [
      _order(id: 'delivered', status: 'DELIVERED'),
      _order(id: 'active', status: 'PREPARING'),
    ]);

    expect(find.text('Rate Order'), findsOneWidget);
  });

  testWidgets('Rate Order remains an independent accessibility action', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    try {
      await _pumpOrders(tester, [_order(id: 'order-1', status: 'DELIVERED')]);

      expect(find.bySemanticsLabel('Rate Order'), findsOneWidget);
    } finally {
      semantics.dispose();
    }
  });

  testWidgets('existing review renders rating and comment', (tester) async {
    await _pumpOrders(tester, [
      _order(
        id: 'reviewed',
        status: 'DELIVERED',
        review: OrderReviewDto(
          id: 'review-1',
          orderId: 'reviewed',
          customerId: 'customer-1',
          restaurantId: 'restaurant-1',
          rating: 4,
          comment: 'Very good',
          createdAt: DateTime(2026),
          updatedAt: DateTime(2026),
        ),
      ),
    ]);

    expect(find.text('Reviewed'), findsOneWidget);
    expect(find.text('Very good'), findsOneWidget);
    expect(find.text('Rate Order'), findsNothing);
    expect(find.byIcon(Icons.star), findsNWidgets(4));
    expect(find.byIcon(Icons.star_border), findsOneWidget);
  });

  testWidgets('review sheet requires stars and limits comments', (
    tester,
  ) async {
    await _pumpOrders(tester, [_order(id: 'order-1', status: 'DELIVERED')]);

    await tester.tap(find.text('Rate Order'));
    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsOneWidget);
    expect(tester.widget<TextField>(find.byType(TextField)).maxLength, 1000);

    await tester.tap(find.text('Submit'));
    await tester.pump();

    expect(find.text('Select a rating'), findsOneWidget);
    expect(find.text('Rate Test Restaurant'), findsOneWidget);
  });

  testWidgets('successful submission trims comment and refreshes history', (
    tester,
  ) async {
    final order = _order(id: 'order-1', status: 'DELIVERED');
    final client = _FakeOrderApiClient((_, rating, comment) async {
      expect(rating, 5);
      expect(comment, 'Excellent');
      return order;
    });
    var historyBuilds = 0;

    await _pumpOrders(
      tester,
      [order],
      client: client,
      onHistoryBuild: () => historyBuilds++,
    );
    await _submitReview(tester, comment: '  Excellent  ');

    expect(find.text('Review submitted'), findsOneWidget);
    expect(historyBuilds, greaterThanOrEqualTo(2));
  });

  testWidgets('failed submission reports error and permits retry', (
    tester,
  ) async {
    final order = _order(id: 'order-1', status: 'DELIVERED');
    var attempts = 0;
    final client = _FakeOrderApiClient((_, _, _) async {
      attempts++;
      if (attempts == 1) throw StateError('network unavailable');
      return order;
    });

    await _pumpOrders(tester, [order], client: client);
    await _submitReview(tester);

    expect(find.textContaining('Failed to submit review'), findsOneWidget);
    expect(find.text('Rate Order'), findsOneWidget);

    tester
        .state<ScaffoldMessengerState>(find.byType(ScaffoldMessenger))
        .hideCurrentSnackBar();
    await tester.pumpAndSettle();

    await _submitReview(tester);
    expect(attempts, 2);
    expect(find.text('Review submitted'), findsOneWidget);
  });

  testWidgets('submission loading state is isolated by order id', (
    tester,
  ) async {
    final pending = Completer<OrderDto>();
    final first = _order(id: 'order-1', status: 'DELIVERED');
    final second = _order(id: 'order-2', status: 'DELIVERED');
    final client = _FakeOrderApiClient((orderId, _, _) {
      if (orderId == first.id) return pending.future;
      return Future.value(second);
    });

    await _pumpOrders(tester, [first, second], client: client);
    await tester.tap(find.text('Rate Order').first);
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('5 stars'));
    await tester.tap(find.text('Submit'));
    await tester.pump();

    expect(find.text('Submitting…'), findsOneWidget);
    expect(find.text('Rate Order'), findsOneWidget);

    pending.complete(first);
    await tester.pumpAndSettle();
  });
}

Future<void> _pumpOrders(
  WidgetTester tester,
  List<OrderDto> orders, {
  OrderApiClient? client,
  VoidCallback? onHistoryBuild,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        orderHistoryProvider.overrideWith((ref) async {
          onHistoryBuild?.call();
          return orders;
        }),
        if (client != null) orderApiClientProvider.overrideWithValue(client),
      ],
      child: const MaterialApp(home: OrdersScreen()),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _submitReview(WidgetTester tester, {String? comment}) async {
  await tester.tap(find.text('Rate Order'));
  await tester.pumpAndSettle();
  await tester.tap(find.byTooltip('5 stars'));
  if (comment != null) {
    await tester.enterText(find.byType(TextField), comment);
  }
  await tester.tap(find.text('Submit'));
  await tester.pumpAndSettle();
}

OrderDto _order({
  required String id,
  required String status,
  OrderReviewDto? review,
}) {
  return OrderDto(
    id: id,
    customerId: 'customer-1',
    restaurantId: 'restaurant-1',
    status: status,
    totalAmount: 24.50,
    deliveryAddress: '1 Test Street',
    createdAt: DateTime(2026),
    orderItems: const [],
    restaurant: const OrderRestaurantDto(
      id: 'restaurant-1',
      name: 'Test Restaurant',
    ),
    review: review,
  );
}

class _FakeOrderApiClient extends OrderApiClient {
  _FakeOrderApiClient(this._submit) : super(Dio());

  final Future<OrderDto> Function(String orderId, int rating, String? comment)
  _submit;

  @override
  Future<OrderDto> submitReview({
    required String orderId,
    required int rating,
    String? comment,
  }) => _submit(orderId, rating, comment);
}
