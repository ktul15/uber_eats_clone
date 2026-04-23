import 'package:restaurant_dashboard/features/menu/data/data_sources/menu_api_client.dart';
import 'package:restaurant_dashboard/features/menu/domain/models/menu_item.dart';
import 'package:restaurant_dashboard/features/menu/domain/models/restaurant.dart';
import 'package:restaurant_dashboard/features/menu/domain/repositories/menu_repository.dart';
import 'package:restaurant_dashboard/shared/providers/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'menu_providers.g.dart';

@riverpod
MenuApiClient menuApiClient(Ref ref) {
  final dio = ref.watch(dioProvider);
  return MenuApiClient(dio);
}

@riverpod
MenuRepository menuRepository(Ref ref) {
  final apiClient = ref.watch(menuApiClientProvider);
  return MenuRepository(apiClient: apiClient);
}

@riverpod
class MyRestaurantsController extends _$MyRestaurantsController {
  @override
  FutureOr<List<Restaurant>> build() {
    return ref.watch(menuRepositoryProvider).getMyRestaurants();
  }

  Future<void> updateRestaurantStatus(
    String restaurantId,
    bool isActive,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final updatedRestaurant = await ref
          .read(menuRepositoryProvider)
          .updateRestaurant(
            restaurantId: restaurantId,
            payload: {'isActive': isActive},
          );

      final currentList = state.value ?? [];
      return currentList
          .map((res) => res.id == restaurantId ? updatedRestaurant : res)
          .toList();
    });
  }

  Future<void> updateRestaurantImage(
    String restaurantId,
    String imageUrl,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final updatedRestaurant = await ref
          .read(menuRepositoryProvider)
          .updateRestaurant(
            restaurantId: restaurantId,
            payload: {'imageUrl': imageUrl},
          );

      final currentList = state.value ?? [];
      return currentList
          .map((res) => res.id == restaurantId ? updatedRestaurant : res)
          .toList();
    });
  }
}

@riverpod
class MenuListController extends _$MenuListController {
  @override
  FutureOr<List<MenuItem>> build(String restaurantId) {
    return ref.watch(menuRepositoryProvider).getMenu(restaurantId);
  }

  Future<void> addMenuItem(Map<String, dynamic> payload) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final newItem = await ref
          .read(menuRepositoryProvider)
          .addMenuItem(restaurantId: restaurantId, payload: payload);
      final currentList = state.value ?? [];
      return [...currentList, newItem];
    });
  }

  Future<void> updateMenuItem(
    String menuItemId,
    Map<String, dynamic> payload,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final updatedItem = await ref
          .read(menuRepositoryProvider)
          .updateMenuItem(
            restaurantId: restaurantId,
            menuItemId: menuItemId,
            payload: payload,
          );
      final currentList = state.value ?? [];
      return currentList
          .map((item) => item.id == menuItemId ? updatedItem : item)
          .toList();
    });
  }

  Future<void> deleteMenuItem(String menuItemId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(menuRepositoryProvider)
          .deleteMenuItem(restaurantId: restaurantId, menuItemId: menuItemId);
      final currentList = state.value ?? [];
      return currentList.where((item) => item.id != menuItemId).toList();
    });
  }
}
