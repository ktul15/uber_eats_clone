import 'package:dio/dio.dart';
import 'package:customer_app/features/cart/data/models/cart_dto.dart';

class CartApiClient {
  final Dio _dio;

  CartApiClient(this._dio);

  Future<CartDto?> getCart() async {
    final response = await _dio.get('/api/cart');
    final data = (response.data as Map<String, dynamic>)['data'];
    if (data == null) return null;
    return CartDto.fromJson(data as Map<String, dynamic>);
  }

  Future<CartDto> addItem({
    required String menuItemId,
    required int quantity,
  }) async {
    final response = await _dio.post(
      '/api/cart/items',
      data: {'menuItemId': menuItemId, 'quantity': quantity},
    );
    return CartDto.fromJson(
      (response.data as Map<String, dynamic>)['data'] as Map<String, dynamic>,
    );
  }

  Future<CartDto?> updateItem({
    required String cartItemId,
    required int quantity,
  }) async {
    final response = await _dio.put(
      '/api/cart/items/$cartItemId',
      data: {'quantity': quantity},
    );
    final data = (response.data as Map<String, dynamic>)['data'];
    if (data == null) return null;
    return CartDto.fromJson(data as Map<String, dynamic>);
  }

  Future<CartDto?> removeItem({required String cartItemId}) async {
    final response = await _dio.delete('/api/cart/items/$cartItemId');
    final data = (response.data as Map<String, dynamic>)['data'];
    if (data == null) return null;
    return CartDto.fromJson(data as Map<String, dynamic>);
  }

  Future<void> clearCart() async {
    await _dio.delete('/api/cart');
  }
}
