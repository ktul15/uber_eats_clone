import 'package:dio/dio.dart';
import 'package:customer_app/features/restaurants/data/models/restaurant_detail_dto.dart';
import 'package:customer_app/features/restaurants/data/models/restaurant_dto.dart';
import 'package:customer_app/shared/constants/api_constants.dart';

class RestaurantApiClient {
  final Dio _dio;

  RestaurantApiClient(this._dio);

  Future<List<RestaurantDto>> getRestaurants({String? search}) async {
    final queryParameters = <String, dynamic>{};
    if (search != null && search.isNotEmpty) {
      queryParameters['search'] = search;
    }

    final response = await _dio.get(
      ApiConstants.restaurants,
      queryParameters: queryParameters,
    );

    final data = (response.data as Map<String, dynamic>)['data'] as List;
    return data
        .map((item) => RestaurantDto.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<RestaurantDetailDto> getRestaurantById(String id) async {
    final response = await _dio.get('${ApiConstants.restaurants}/$id');
    return RestaurantDetailDto.fromJson(
      (response.data as Map<String, dynamic>)['data'] as Map<String, dynamic>,
    );
  }
}
