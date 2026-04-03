import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item.freezed.dart';

@freezed
abstract class CartItemMenuItem with _$CartItemMenuItem {
  const factory CartItemMenuItem({
    required String id,
    required String name,
    String? description,
    required double price,
    String? imageUrl,
    required bool isAvailable,
  }) = _CartItemMenuItem;
}

@freezed
abstract class CartItem with _$CartItem {
  const factory CartItem({
    required String id,
    required String cartId,
    required String menuItemId,
    required int quantity,
    required CartItemMenuItem menuItem,
  }) = _CartItem;
}
