import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:driver_app/features/deliveries/data/data_sources/delivery_api_client.dart';
import 'package:driver_app/features/deliveries/domain/models/active_delivery.dart';
import 'package:driver_app/shared/providers/dio_provider.dart';

part 'delivery_providers.g.dart';

@riverpod
DeliveryApiClient deliveryApiClient(Ref ref) {
  final dio = ref.watch(dioProvider);
  const storage = FlutterSecureStorage();
  return DeliveryApiClient(dio: dio, storage: storage);
}

@riverpod
class AcceptDelivery extends _$AcceptDelivery {
  @override
  FutureOr<void> build() => null;

  Future<void> execute(String orderId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      return ref.read(deliveryApiClientProvider).acceptDelivery(orderId);
    });
  }
}

@riverpod
Future<ActiveDelivery?> activeDelivery(Ref ref) async {
  final dto = await ref.read(deliveryApiClientProvider).getActiveDelivery();
  if (dto == null) return null;
  return ActiveDelivery(
    id: dto.id,
    orderId: dto.orderId,
    status: DeliveryStatus.fromString(dto.status),
    restaurantName: dto.order.restaurant.name,
    restaurantAddress: dto.order.restaurant.address,
    deliveryAddress: dto.order.deliveryAddress,
    totalAmount: double.parse(dto.order.totalAmount),
    orderItems: dto.order.orderItems
        .map(
          (item) => ActiveOrderItem(
            name: item.menuItem.name,
            quantity: item.quantity,
          ),
        )
        .toList(),
  );
}

@riverpod
class UpdateDeliveryStatus extends _$UpdateDeliveryStatus {
  @override
  FutureOr<void> build() => null;

  Future<void> execute(String deliveryId, DeliveryStatus status) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      return ref
          .read(deliveryApiClientProvider)
          .updateDeliveryStatus(deliveryId, status.apiValue);
    });
    if (state.hasValue) ref.invalidate(activeDeliveryProvider);
  }
}
