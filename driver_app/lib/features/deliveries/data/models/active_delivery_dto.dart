import 'package:freezed_annotation/freezed_annotation.dart';

part 'active_delivery_dto.freezed.dart';
part 'active_delivery_dto.g.dart';

@freezed
abstract class ActiveMenuItemDto with _$ActiveMenuItemDto {
  const factory ActiveMenuItemDto({required String name}) = _ActiveMenuItemDto;

  factory ActiveMenuItemDto.fromJson(Map<String, dynamic> json) =>
      _$ActiveMenuItemDtoFromJson(json);
}

@freezed
abstract class ActiveOrderItemDto with _$ActiveOrderItemDto {
  const factory ActiveOrderItemDto({
    required int quantity,
    required ActiveMenuItemDto menuItem,
  }) = _ActiveOrderItemDto;

  factory ActiveOrderItemDto.fromJson(Map<String, dynamic> json) =>
      _$ActiveOrderItemDtoFromJson(json);
}

@freezed
abstract class ActiveRestaurantDto with _$ActiveRestaurantDto {
  const factory ActiveRestaurantDto({
    required String name,
    required String address,
  }) = _ActiveRestaurantDto;

  factory ActiveRestaurantDto.fromJson(Map<String, dynamic> json) =>
      _$ActiveRestaurantDtoFromJson(json);
}

@freezed
abstract class ActiveDeliveryOrderDto with _$ActiveDeliveryOrderDto {
  const factory ActiveDeliveryOrderDto({
    required String deliveryAddress,
    required String totalAmount,
    required ActiveRestaurantDto restaurant,
    required List<ActiveOrderItemDto> orderItems,
  }) = _ActiveDeliveryOrderDto;

  factory ActiveDeliveryOrderDto.fromJson(Map<String, dynamic> json) =>
      _$ActiveDeliveryOrderDtoFromJson(json);
}

@freezed
abstract class ActiveDeliveryDto with _$ActiveDeliveryDto {
  const factory ActiveDeliveryDto({
    required String id,
    required String orderId,
    required String status,
    required ActiveDeliveryOrderDto order,
  }) = _ActiveDeliveryDto;

  factory ActiveDeliveryDto.fromJson(Map<String, dynamic> json) =>
      _$ActiveDeliveryDtoFromJson(json);
}
