import 'package:dio/dio.dart';
import 'package:restaurant_dashboard/features/menu/data/models/menu_item_dto.dart';
import 'package:restaurant_dashboard/features/menu/data/models/restaurant_dto.dart';
import 'package:restaurant_dashboard/shared/constants/api_constants.dart';

class MenuApiClient {
  final Dio _dio;

  MenuApiClient(this._dio);

  Future<List<RestaurantDto>> getMyRestaurants() async {
    final response = await _dio.get(ApiConstants.myRestaurants);
    final data = (response.data as Map<String, dynamic>)['data'] as List;
    return data.map((json) => RestaurantDto.fromJson(json)).toList();
  }

  Future<List<MenuItemDto>> getMenu(String restaurantId) async {
    final response = await _dio.get(ApiConstants.restaurantMenu(restaurantId));
    final data = (response.data as Map<String, dynamic>)['data'] as List;
    return data.map((json) => MenuItemDto.fromJson(json)).toList();
  }

  Future<MenuItemDto> addMenuItem({
    required String restaurantId,
    required Map<String, dynamic> payload,
  }) async {
    final response = await _dio.post(
      ApiConstants.restaurantMenu(restaurantId),
      data: payload,
    );
    return MenuItemDto.fromJson(
      (response.data as Map<String, dynamic>)['data'],
    );
  }

  Future<MenuItemDto> updateMenuItem({
    required String restaurantId,
    required String menuItemId,
    required Map<String, dynamic> payload,
  }) async {
    final response = await _dio.put(
      '${ApiConstants.restaurantMenu(restaurantId)}/$menuItemId',
      data: payload,
    );
    return MenuItemDto.fromJson(
      (response.data as Map<String, dynamic>)['data'],
    );
  }

  Future<void> deleteMenuItem({
    required String restaurantId,
    required String menuItemId,
  }) async {
    await _dio.delete(
      '${ApiConstants.restaurantMenu(restaurantId)}/$menuItemId',
    );
  }

  Future<RestaurantDto> updateRestaurant({
    required String restaurantId,
    required Map<String, dynamic> payload,
  }) async {
    final response = await _dio.put(
      ApiConstants.restaurantById(restaurantId),
      data: payload,
    );
    return RestaurantDto.fromJson(
      (response.data as Map<String, dynamic>)['data'],
    );
  }

  Future<String> uploadImage(String filePath) async {
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(filePath),
    });
    final response = await _dio.post(ApiConstants.upload, data: formData);
    return (response.data as Map<String, dynamic>)['data']['url'] as String;
  }
}
