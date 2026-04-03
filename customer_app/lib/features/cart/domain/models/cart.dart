import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:customer_app/features/cart/domain/models/cart_item.dart';

part 'cart.freezed.dart';

@freezed
abstract class CartRestaurant with _$CartRestaurant {
  const factory CartRestaurant({
    required String id,
    required String name,
    String? imageUrl,
  }) = _CartRestaurant;
}

@freezed
abstract class Cart with _$Cart {
  const factory Cart({
    required String id,
    required String customerId,
    required String restaurantId,
    required CartRestaurant restaurant,
    required List<CartItem> items,
  }) = _Cart;

  const Cart._();

  double get totalAmount =>
      items.fold(0, (sum, item) => sum + (item.menuItem.price * item.quantity));

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);
}
