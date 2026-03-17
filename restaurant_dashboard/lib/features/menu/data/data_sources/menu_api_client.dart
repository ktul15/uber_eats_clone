import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:restaurant_dashboard/features/menu/data/models/menu_item_dto.dart';
import 'package:restaurant_dashboard/features/menu/data/models/restaurant_dto.dart';
import 'package:restaurant_dashboard/shared/constants/api_constants.dart';

class MenuApiClient {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  static const _tokenKey = 'auth_token';

  MenuApiClient({required Dio dio, required FlutterSecureStorage storage})
    : _dio = dio,
      _storage = storage;

  Future<Options> _getAuthOptions() async {
    final token = await _storage.read(key: _tokenKey);
    return Options(headers: {'Authorization': 'Bearer $token'});
  }

  Future<List<RestaurantDto>> getMyRestaurants() async {
    final options = await _getAuthOptions();
    final response = await _dio.get(
      ApiConstants.myRestaurants,
      options: options,
    );

    final data = (response.data as Map<String, dynamic>)["data"] as List;
    return data.map((json) => RestaurantDto.fromJson(json)).toList();
  }

  Future<List<MenuItemDto>> getMenu(String restaurantId) async {
    final options = await _getAuthOptions();
    final response = await _dio.get(
      ApiConstants.restaurantMenu(restaurantId),
      options: options,
    );

    final data = (response.data as Map<String, dynamic>)["data"] as List;
    return data.map((json) => MenuItemDto.fromJson(json)).toList();
  }

  Future<MenuItemDto> addMenuItem({
    required String restaurantId,
    required Map<String, dynamic> payload,
  }) async {
    final options = await _getAuthOptions();
    final response = await _dio.post(
      ApiConstants.restaurantMenu(restaurantId),
      data: payload,
      options: options,
    );

    return MenuItemDto.fromJson(
      (response.data as Map<String, dynamic>)["data"],
    );
  }

  Future<MenuItemDto> updateMenuItem({
    required String restaurantId,
    required String menuItemId,
    required Map<String, dynamic> payload,
  }) async {
    final options = await _getAuthOptions();
    final response = await _dio.put(
      '${ApiConstants.restaurantMenu(restaurantId)}/$menuItemId',
      data: payload,
      options: options,
    );

    return MenuItemDto.fromJson(
      (response.data as Map<String, dynamic>)["data"],
    );
  }

  Future<void> deleteMenuItem({
    required String restaurantId,
    required String menuItemId,
  }) async {
    final options = await _getAuthOptions();
    await _dio.delete(
      '${ApiConstants.restaurantMenu(restaurantId)}/$menuItemId',
      options: options,
    );
  }

  Future<RestaurantDto> updateRestaurant({
    required String restaurantId,
    required Map<String, dynamic> payload,
  }) async {
    final options = await _getAuthOptions();
    final response = await _dio.put(
      ApiConstants.restaurantById(restaurantId),
      data: payload,
      options: options,
    );

    return RestaurantDto.fromJson(
      (response.data as Map<String, dynamic>)["data"],
    );
  }
}
