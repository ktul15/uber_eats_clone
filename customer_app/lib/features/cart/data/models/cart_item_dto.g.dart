// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CartItemMenuItemDto _$CartItemMenuItemDtoFromJson(Map<String, dynamic> json) =>
    _CartItemMenuItemDto(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String?,
      isAvailable: json['isAvailable'] as bool,
    );

Map<String, dynamic> _$CartItemMenuItemDtoToJson(
  _CartItemMenuItemDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'price': instance.price,
  'imageUrl': instance.imageUrl,
  'isAvailable': instance.isAvailable,
};

_CartItemDto _$CartItemDtoFromJson(Map<String, dynamic> json) => _CartItemDto(
  id: json['id'] as String,
  cartId: json['cartId'] as String,
  menuItemId: json['menuItemId'] as String,
  quantity: (json['quantity'] as num).toInt(),
  menuItem: CartItemMenuItemDto.fromJson(
    json['menuItem'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$CartItemDtoToJson(_CartItemDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cartId': instance.cartId,
      'menuItemId': instance.menuItemId,
      'quantity': instance.quantity,
      'menuItem': instance.menuItem,
    };
