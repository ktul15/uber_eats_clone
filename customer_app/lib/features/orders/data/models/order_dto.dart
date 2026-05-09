import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:customer_app/features/orders/data/models/order_item_dto.dart';

part 'order_dto.freezed.dart';
part 'order_dto.g.dart';

double _doubleFromJson(dynamic value) {
  if (value is double) return value;
  if (value is int) return value.toDouble();
  return double.parse(value.toString());
}

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
abstract class OrderReviewDto with _$OrderReviewDto {
  const factory OrderReviewDto({
    required String id,
    required String orderId,
    required String customerId,
    required String restaurantId,
    required int rating,
    String? comment,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _OrderReviewDto;

  factory OrderReviewDto.fromJson(Map<String, dynamic> json) =>
      _$OrderReviewDtoFromJson(json);
}

@freezed
abstract class OrderDto with _$OrderDto {
  const factory OrderDto({
    required String id,
    required String customerId,
    required String restaurantId,
    required String status,
    @JsonKey(fromJson: _doubleFromJson) required double totalAmount,
    required String deliveryAddress,
    required DateTime createdAt,
    required List<OrderItemDto> orderItems,
    required OrderRestaurantDto restaurant,
    OrderReviewDto? review,
  }) = _OrderDto;

  factory OrderDto.fromJson(Map<String, dynamic> json) =>
      _$OrderDtoFromJson(json);
}
