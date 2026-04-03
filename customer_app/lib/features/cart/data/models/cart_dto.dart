import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:customer_app/features/cart/data/models/cart_item_dto.dart';

part 'cart_dto.freezed.dart';
part 'cart_dto.g.dart';

@freezed
abstract class CartRestaurantDto with _$CartRestaurantDto {
  const factory CartRestaurantDto({
    required String id,
    required String name,
    String? imageUrl,
  }) = _CartRestaurantDto;

  factory CartRestaurantDto.fromJson(Map<String, dynamic> json) =>
      _$CartRestaurantDtoFromJson(json);
}

@freezed
abstract class CartDto with _$CartDto {
  const factory CartDto({
    required String id,
    required String customerId,
    required String restaurantId,
    required CartRestaurantDto restaurant,
    required List<CartItemDto> items,
  }) = _CartDto;

  factory CartDto.fromJson(Map<String, dynamic> json) =>
      _$CartDtoFromJson(json);
}
