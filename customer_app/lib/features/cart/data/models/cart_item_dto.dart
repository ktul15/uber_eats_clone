import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item_dto.freezed.dart';
part 'cart_item_dto.g.dart';

@freezed
abstract class CartItemMenuItemDto with _$CartItemMenuItemDto {
  const factory CartItemMenuItemDto({
    required String id,
    required String name,
    String? description,
    required double price,
    String? imageUrl,
    required bool isAvailable,
  }) = _CartItemMenuItemDto;

  factory CartItemMenuItemDto.fromJson(Map<String, dynamic> json) =>
      _$CartItemMenuItemDtoFromJson(json);
}

@freezed
abstract class CartItemDto with _$CartItemDto {
  const factory CartItemDto({
    required String id,
    required String cartId,
    required String menuItemId,
    required int quantity,
    required CartItemMenuItemDto menuItem,
  }) = _CartItemDto;

  factory CartItemDto.fromJson(Map<String, dynamic> json) =>
      _$CartItemDtoFromJson(json);
}
