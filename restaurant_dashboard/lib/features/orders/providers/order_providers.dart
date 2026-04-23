import 'package:restaurant_dashboard/features/orders/data/data_sources/order_api_client.dart';
import 'package:restaurant_dashboard/features/orders/data/models/order_dto.dart';
import 'package:restaurant_dashboard/features/orders/domain/repositories/order_repository.dart';
import 'package:restaurant_dashboard/shared/providers/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_providers.g.dart';

@riverpod
OrderApiClient orderApiClient(Ref ref) {
  final dio = ref.watch(dioProvider);
  return OrderApiClient(dio);
}

@riverpod
OrderRepository orderRepository(Ref ref) {
  final apiClient = ref.watch(orderApiClientProvider);
  return OrderRepository(apiClient: apiClient);
}

@riverpod
class ActiveOrdersController extends _$ActiveOrdersController {
  static const _activeStatuses = {
    'PENDING',
    'ACCEPTED',
    'PREPARING',
    'READY',
    'PICKED_UP',
  };

  @override
  FutureOr<List<OrderDto>> build() async {
    final orders = await ref.read(orderRepositoryProvider).getOrders();
    return orders.where((o) => _activeStatuses.contains(o.status)).toList();
  }

  Future<void> updateStatus(String orderId, String newStatus) async {
    final previous = state.requireValue;
    try {
      final updated = await ref
          .read(orderRepositoryProvider)
          .updateOrderStatus(orderId, newStatus);
      if (!_activeStatuses.contains(updated.status)) {
        state = AsyncData(previous.where((o) => o.id != orderId).toList());
      } else {
        state = AsyncData(
          previous.map((o) => o.id == orderId ? updated : o).toList(),
        );
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final orders = await ref.read(orderRepositoryProvider).getOrders();
      return orders.where((o) => _activeStatuses.contains(o.status)).toList();
    });
  }
}
