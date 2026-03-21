import 'package:restaurant_dashboard/features/menu/data/data_sources/menu_api_client.dart';
import 'package:restaurant_dashboard/features/menu/domain/models/menu_item.dart';
import 'package:restaurant_dashboard/features/menu/domain/models/restaurant.dart';

class MenuRepository {
  final MenuApiClient _apiClient;

  MenuRepository({required MenuApiClient apiClient}) : _apiClient = apiClient;

  Future<List<Restaurant>> getMyRestaurants() async {
    final dtos = await _apiClient.getMyRestaurants();
    return dtos
        .map(
          (dto) => Restaurant(
            id: dto.id,
            ownerId: dto.ownerId,
            name: dto.name,
            isActive: dto.isActive,
            description: dto.description,
            address: dto.address,
            imageUrl: dto.imageUrl,
            menuItems: dto.menuItems
                .map(
                  (itemDto) => MenuItem(
                    id: itemDto.id,
                    restaurantId: itemDto.restaurantId,
                    name: itemDto.name,
                    price: itemDto.price,
                    isAvailable: itemDto.isAvailable,
                    description: itemDto.description,
                    imageUrl: itemDto.imageUrl,
                  ),
                )
                .toList(),
          ),
        )
        .toList();
  }

  Future<List<MenuItem>> getMenu(String restaurantId) async {
    final dtos = await _apiClient.getMenu(restaurantId);
    return dtos
        .map(
          (dto) => MenuItem(
            id: dto.id,
            restaurantId: dto.restaurantId,
            name: dto.name,
            price: dto.price,
            isAvailable: dto.isAvailable,
            description: dto.description,
            imageUrl: dto.imageUrl,
          ),
        )
        .toList();
  }

  Future<MenuItem> addMenuItem({
    required String restaurantId,
    required Map<String, dynamic> payload,
  }) async {
    final dto = await _apiClient.addMenuItem(
      restaurantId: restaurantId,
      payload: payload,
    );
    return MenuItem(
      id: dto.id,
      restaurantId: dto.restaurantId,
      name: dto.name,
      price: dto.price,
      isAvailable: dto.isAvailable,
      description: dto.description,
      imageUrl: dto.imageUrl,
    );
  }

  Future<MenuItem> updateMenuItem({
    required String restaurantId,
    required String menuItemId,
    required Map<String, dynamic> payload,
  }) async {
    final dto = await _apiClient.updateMenuItem(
      restaurantId: restaurantId,
      menuItemId: menuItemId,
      payload: payload,
    );
    return MenuItem(
      id: dto.id,
      restaurantId: dto.restaurantId,
      name: dto.name,
      price: dto.price,
      isAvailable: dto.isAvailable,
      description: dto.description,
      imageUrl: dto.imageUrl,
    );
  }

  Future<void> deleteMenuItem({
    required String restaurantId,
    required String menuItemId,
  }) async {
    await _apiClient.deleteMenuItem(
      restaurantId: restaurantId,
      menuItemId: menuItemId,
    );
  }

  Future<Restaurant> updateRestaurant({
    required String restaurantId,
    required Map<String, dynamic> payload,
  }) async {
    final dto = await _apiClient.updateRestaurant(
      restaurantId: restaurantId,
      payload: payload,
    );

    return Restaurant(
      id: dto.id,
      ownerId: dto.ownerId,
      name: dto.name,
      isActive: dto.isActive,
      description: dto.description,
      address: dto.address,
      imageUrl: dto.imageUrl,
      menuItems: dto.menuItems
          .map(
            (itemDto) => MenuItem(
              id: itemDto.id,
              restaurantId: itemDto.restaurantId,
              name: itemDto.name,
              price: itemDto.price,
              isAvailable: itemDto.isAvailable,
              description: itemDto.description,
              imageUrl: itemDto.imageUrl,
            ),
          )
          .toList(),
    );
  }

  Future<String> uploadImage(String filePath) async {
    return _apiClient.uploadImage(filePath);
  }
}
