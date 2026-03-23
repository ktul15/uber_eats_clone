import 'package:customer_app/features/restaurants/data/data_sources/restaurant_api_client.dart';
import 'package:customer_app/features/restaurants/data/models/restaurant_dto.dart';
import 'package:customer_app/features/restaurants/domain/models/restaurant.dart';

class RestaurantRepository {
  final RestaurantApiClient _apiClient;

  RestaurantRepository({required RestaurantApiClient apiClient})
      : _apiClient = apiClient;

  Future<List<Restaurant>> getRestaurants({String? search}) async {
    final dtos = await _apiClient.getRestaurants(search: search);
    return dtos.map(_mapDtoToDomain).toList();
  }

  Restaurant _mapDtoToDomain(RestaurantDto dto) {
    return Restaurant(
      id: dto.id,
      name: dto.name,
      description: dto.description,
      address: dto.address,
      lat: dto.lat,
      lng: dto.lng,
      imageUrl: dto.imageUrl,
      isActive: dto.isActive,
      rating: dto.rating,
    );
  }
}
