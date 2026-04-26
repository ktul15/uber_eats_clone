import 'package:freezed_annotation/freezed_annotation.dart';

part 'active_delivery.freezed.dart';

enum DeliveryStatus {
  assigned,
  atRestaurant,
  inTransit,
  completed;

  static DeliveryStatus fromString(String s) => switch (s) {
        'ASSIGNED' => assigned,
        'AT_RESTAURANT' => atRestaurant,
        'IN_TRANSIT' => inTransit,
        'COMPLETED' => completed,
        _ => throw ArgumentError('Unknown DeliveryStatus: $s'),
      };

  String get apiValue => switch (this) {
        assigned => 'ASSIGNED',
        atRestaurant => 'AT_RESTAURANT',
        inTransit => 'IN_TRANSIT',
        completed => 'COMPLETED',
      };

  DeliveryStatus? get next => switch (this) {
        assigned => atRestaurant,
        atRestaurant => inTransit,
        inTransit => completed,
        completed => null,
      };
}

@freezed
abstract class ActiveOrderItem with _$ActiveOrderItem {
  const factory ActiveOrderItem({
    required String name,
    required int quantity,
  }) = _ActiveOrderItem;
}

@freezed
abstract class ActiveDelivery with _$ActiveDelivery {
  const factory ActiveDelivery({
    required String id,
    required String orderId,
    required DeliveryStatus status,
    required String restaurantName,
    required String restaurantAddress,
    required String deliveryAddress,
    required double totalAmount,
    required List<ActiveOrderItem> orderItems,
  }) = _ActiveDelivery;
}
