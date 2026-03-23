import 'package:customer_app/features/restaurants/data/data_sources/restaurant_api_client.dart';
import 'package:customer_app/features/restaurants/data/models/menu_item_dto.dart';
import 'package:customer_app/features/restaurants/data/models/restaurant_detail_dto.dart';
import 'package:customer_app/features/restaurants/data/models/restaurant_dto.dart';
import 'package:customer_app/features/restaurants/domain/models/menu_item.dart';
import 'package:customer_app/features/restaurants/domain/models/restaurant.dart';
import 'package:customer_app/features/restaurants/domain/models/restaurant_detail.dart';

class RestaurantRepository {
  final RestaurantApiClient _apiClient;

  RestaurantRepository({required RestaurantApiClient apiClient})
      : _apiClient = apiClient;

  Future<List<Restaurant>> getRestaurants({String? search}) async {
    final dtos = await _apiClient.getRestaurants(search: search);
    return dtos.map(_mapDtoToDomain).toList();
  }

  Future<RestaurantDetail> getRestaurantById(String id) async {
    final dto = await _apiClient.getRestaurantById(id);
    return _mapDetailDtoToDomain(dto);
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

  RestaurantDetail _mapDetailDtoToDomain(RestaurantDetailDto dto) {
    return RestaurantDetail(
      id: dto.id,
      name: dto.name,
      description: dto.description,
      address: dto.address,
      lat: dto.lat,
      lng: dto.lng,
      imageUrl: dto.imageUrl,
      isActive: dto.isActive,
      rating: dto.rating,
      menuItems: dto.menuItems.map(_mapMenuItemDtoToDomain).toList(),
    );
  }

  MenuItem _mapMenuItemDtoToDomain(MenuItemDto dto) {
    return MenuItem(
      id: dto.id,
      restaurantId: dto.restaurantId,
      name: dto.name,
      description: dto.description,
      price: dto.price,
      imageUrl: dto.imageUrl,
      isAvailable: dto.isAvailable,
    );
  }
}
