import 'package:customer_app/features/cart/data/data_sources/cart_api_client.dart';
import 'package:customer_app/features/cart/data/models/cart_dto.dart';
import 'package:customer_app/features/cart/domain/models/cart.dart';
import 'package:customer_app/features/cart/domain/models/cart_item.dart';

class CartRepository {
  final CartApiClient _apiClient;

  CartRepository({required CartApiClient apiClient}) : _apiClient = apiClient;

  Future<Cart?> getCart() async {
    final dto = await _apiClient.getCart();
    return dto == null ? null : _mapDtoToDomain(dto);
  }

  Future<Cart> addItem({
    required String menuItemId,
    required int quantity,
  }) async {
    final dto = await _apiClient.addItem(
      menuItemId: menuItemId,
      quantity: quantity,
    );
    return _mapDtoToDomain(dto);
  }

  Future<Cart?> updateItem({
    required String cartItemId,
    required int quantity,
  }) async {
    final dto = await _apiClient.updateItem(
      cartItemId: cartItemId,
      quantity: quantity,
    );
    return dto == null ? null : _mapDtoToDomain(dto);
  }

  Future<Cart?> removeItem({required String cartItemId}) async {
    final dto = await _apiClient.removeItem(cartItemId: cartItemId);
    return dto == null ? null : _mapDtoToDomain(dto);
  }

  Future<void> clearCart() async {
    await _apiClient.clearCart();
  }

  Cart _mapDtoToDomain(CartDto dto) {
    return Cart(
      id: dto.id,
      customerId: dto.customerId,
      restaurantId: dto.restaurantId,
      restaurant: CartRestaurant(
        id: dto.restaurant.id,
        name: dto.restaurant.name,
        imageUrl: dto.restaurant.imageUrl,
      ),
      items: dto.items.map(_mapCartItemDtoToDomain).toList(),
    );
  }

  CartItem _mapCartItemDtoToDomain(dynamic dto) {
    return CartItem(
      id: dto.id,
      cartId: dto.cartId,
      menuItemId: dto.menuItemId,
      quantity: dto.quantity,
      menuItem: CartItemMenuItem(
        id: dto.menuItem.id,
        name: dto.menuItem.name,
        description: dto.menuItem.description,
        price: dto.menuItem.price,
        imageUrl: dto.menuItem.imageUrl,
        isAvailable: dto.menuItem.isAvailable,
      ),
    );
  }
}
