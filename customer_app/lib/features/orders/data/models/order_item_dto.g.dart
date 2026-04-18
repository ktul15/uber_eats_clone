// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderItemMenuItemDto _$OrderItemMenuItemDtoFromJson(
  Map<String, dynamic> json,
) => _OrderItemMenuItemDto(
  id: json['id'] as String,
  name: json['name'] as String,
  imageUrl: json['imageUrl'] as String?,
);

Map<String, dynamic> _$OrderItemMenuItemDtoToJson(
  _OrderItemMenuItemDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'imageUrl': instance.imageUrl,
};

_OrderItemDto _$OrderItemDtoFromJson(Map<String, dynamic> json) =>
    _OrderItemDto(
      id: json['id'] as String,
      orderId: json['orderId'] as String,
      menuItemId: json['menuItemId'] as String,
      quantity: (json['quantity'] as num).toInt(),
      priceAtTime: _doubleFromJson(json['priceAtTime']),
      menuItem: OrderItemMenuItemDto.fromJson(
        json['menuItem'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$OrderItemDtoToJson(_OrderItemDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'menuItemId': instance.menuItemId,
      'quantity': instance.quantity,
      'priceAtTime': instance.priceAtTime,
      'menuItem': instance.menuItem,
    };
