import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:customer_app/features/cart/data/data_sources/cart_api_client.dart';
import 'package:customer_app/features/cart/domain/models/cart.dart';
import 'package:customer_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:customer_app/shared/providers/dio_provider.dart';

part 'cart_providers.g.dart';

// --- Infrastructure ---

@riverpod
CartApiClient cartApiClient(Ref ref) {
  final dio = ref.watch(dioProvider);
  return CartApiClient(dio);
}

@riverpod
CartRepository cartRepository(Ref ref) {
  final apiClient = ref.watch(cartApiClientProvider);
  return CartRepository(apiClient: apiClient);
}

// --- Cart State ---

@riverpod
class CartNotifier extends _$CartNotifier {
  @override
  Future<Cart?> build() async {
    final repo = ref.watch(cartRepositoryProvider);
    return repo.getCart();
  }

  Future<void> addItem({
    required String menuItemId,
    required int quantity,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      final repo = ref.read(cartRepositoryProvider);
      return repo.addItem(menuItemId: menuItemId, quantity: quantity);
    });
  }

  Future<void> updateItem({
    required String cartItemId,
    required int quantity,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      final repo = ref.read(cartRepositoryProvider);
      return repo.updateItem(cartItemId: cartItemId, quantity: quantity);
    });
  }

  Future<void> removeItem({required String cartItemId}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      final repo = ref.read(cartRepositoryProvider);
      return repo.removeItem(cartItemId: cartItemId);
    });
  }

  Future<void> clearCart() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(cartRepositoryProvider);
      await repo.clearCart();
      return null;
    });
  }
}
