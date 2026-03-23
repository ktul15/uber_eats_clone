import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:customer_app/features/restaurants/data/data_sources/restaurant_api_client.dart';
import 'package:customer_app/features/restaurants/data/repositories/restaurant_repository.dart';
import 'package:customer_app/features/restaurants/domain/models/restaurant.dart';
import 'package:customer_app/shared/providers/dio_provider.dart';

part 'restaurant_providers.g.dart';

// --- Infrastructure ---

@riverpod
RestaurantApiClient restaurantApiClient(Ref ref) {
  final dio = ref.watch(dioProvider);
  return RestaurantApiClient(dio);
}

@riverpod
RestaurantRepository restaurantRepository(Ref ref) {
  final apiClient = ref.watch(restaurantApiClientProvider);
  return RestaurantRepository(apiClient: apiClient);
}

// --- Search State ---

@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';

  void update(String query) => state = query;
}

// --- Restaurant List ---

@riverpod
Future<List<Restaurant>> restaurantList(Ref ref) async {
  final query = ref.watch(searchQueryProvider);
  final repo = ref.watch(restaurantRepositoryProvider);
  return repo.getRestaurants(search: query.isEmpty ? null : query);
}
