import 'package:freezed_annotation/freezed_annotation.dart';

part 'available_order.freezed.dart';

@freezed
abstract class AvailableOrder with _$AvailableOrder {
  const factory AvailableOrder({
    required String orderId,
    required String restaurantId,
    required String restaurantName,
    required String deliveryAddress,
    required double totalAmount,
  }) = _AvailableOrder;
}
