import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_item_dto.freezed.dart';
part 'order_item_dto.g.dart';

@freezed
abstract class OrderItemMenuItemDto with _$OrderItemMenuItemDto {
  const factory OrderItemMenuItemDto({
    required String id,
    required String name,
    String? imageUrl,
  }) = _OrderItemMenuItemDto;

  factory OrderItemMenuItemDto.fromJson(Map<String, dynamic> json) =>
      _$OrderItemMenuItemDtoFromJson(json);
}

@freezed
abstract class OrderItemDto with _$OrderItemDto {
  const factory OrderItemDto({
    required String id,
    required String orderId,
    required String menuItemId,
    required int quantity,
    required double priceAtTime,
    required OrderItemMenuItemDto menuItem,
  }) = _OrderItemDto;

  factory OrderItemDto.fromJson(Map<String, dynamic> json) =>
      _$OrderItemDtoFromJson(json);
}
