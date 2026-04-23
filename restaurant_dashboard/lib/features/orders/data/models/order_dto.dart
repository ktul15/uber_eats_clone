import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:restaurant_dashboard/features/orders/data/models/order_item_dto.dart';
import 'package:restaurant_dashboard/shared/utils/json_converters.dart';

part 'order_dto.freezed.dart';
part 'order_dto.g.dart';

@freezed
abstract class OrderRestaurantDto with _$OrderRestaurantDto {
  const factory OrderRestaurantDto({
    required String id,
    required String name,
    String? imageUrl,
  }) = _OrderRestaurantDto;

  factory OrderRestaurantDto.fromJson(Map<String, dynamic> json) =>
      _$OrderRestaurantDtoFromJson(json);
}

@freezed
abstract class OrderDto with _$OrderDto {
  const factory OrderDto({
    required String id,
    required String customerId,
    required String restaurantId,
    required String status,
    @JsonKey(fromJson: doubleFromJson) required double totalAmount,
    required String deliveryAddress,
    required DateTime createdAt,
    required List<OrderItemDto> orderItems,
    required OrderRestaurantDto restaurant,
  }) = _OrderDto;

  factory OrderDto.fromJson(Map<String, dynamic> json) =>
      _$OrderDtoFromJson(json);
}
