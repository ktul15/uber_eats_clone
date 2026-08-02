import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:customer_app/features/cart/providers/cart_providers.dart';
import 'package:customer_app/features/orders/data/data_sources/order_api_client.dart';
import 'package:customer_app/features/orders/data/models/order_dto.dart';
import 'package:customer_app/shared/providers/dio_provider.dart';

part 'order_providers.g.dart';

// --- Infrastructure ---

@riverpod
OrderApiClient orderApiClient(Ref ref) {
  final dio = ref.watch(dioProvider);
  return OrderApiClient(dio);
}

// --- Place Order Notifier ---

@riverpod
class PlaceOrder extends _$PlaceOrder {
  @override
  FutureOr<OrderDto?> build() => null;

  Future<void> execute({
    required String deliveryAddress,
    required String paymentIntentId,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final client = ref.read(orderApiClientProvider);
      final order = await client.placeOrder(
        deliveryAddress: deliveryAddress,
        paymentIntentId: paymentIntentId,
      );
      // Clear the cart state locally (backend deletes it too)
      ref.invalidate(cartProvider);
      return order;
    });
  }
}

// --- Create Payment Intent ---

@riverpod
class CreatePaymentIntent extends _$CreatePaymentIntent {
  @override
  FutureOr<String?> build() => null;

  Future<String?> execute() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      final client = ref.read(orderApiClientProvider);
      return client.createPaymentIntent();
    });
    return state.value;
  }
}

// --- Order History ---

@riverpod
Future<List<OrderDto>> orderHistory(Ref ref) async {
  final client = ref.watch(orderApiClientProvider);
  return client.getOrders();
}

// --- Submit Review ---

@riverpod
class SubmitReview extends _$SubmitReview {
  @override
  FutureOr<OrderDto?> build(String orderId) => null;

  Future<AsyncValue<OrderDto?>> execute({
    required int rating,
    String? comment,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final client = ref.read(orderApiClientProvider);
      final order = await client.submitReview(
        orderId: orderId,
        rating: rating,
        comment: comment?.trim(),
      );
      ref.invalidate(orderHistoryProvider);
      return order;
    });
    return state;
  }
}
