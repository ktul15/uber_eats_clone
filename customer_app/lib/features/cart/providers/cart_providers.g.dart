// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(cartApiClient)
final cartApiClientProvider = CartApiClientProvider._();

final class CartApiClientProvider
    extends $FunctionalProvider<CartApiClient, CartApiClient, CartApiClient>
    with $Provider<CartApiClient> {
  CartApiClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cartApiClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cartApiClientHash();

  @$internal
  @override
  $ProviderElement<CartApiClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CartApiClient create(Ref ref) {
    return cartApiClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CartApiClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CartApiClient>(value),
    );
  }
}

String _$cartApiClientHash() => r'd7bf32f18e0c0d503d574af0a98cc05a0df2a150';

@ProviderFor(cartRepository)
final cartRepositoryProvider = CartRepositoryProvider._();

final class CartRepositoryProvider
    extends $FunctionalProvider<CartRepository, CartRepository, CartRepository>
    with $Provider<CartRepository> {
  CartRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cartRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cartRepositoryHash();

  @$internal
  @override
  $ProviderElement<CartRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CartRepository create(Ref ref) {
    return cartRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CartRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CartRepository>(value),
    );
  }
}

String _$cartRepositoryHash() => r'c7ea90048cfcc0e9ddfa61f43f939ca0d0063c5f';

@ProviderFor(CartNotifier)
final cartProvider = CartNotifierProvider._();

final class CartNotifierProvider
    extends $AsyncNotifierProvider<CartNotifier, Cart?> {
  CartNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cartProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cartNotifierHash();

  @$internal
  @override
  CartNotifier create() => CartNotifier();
}

String _$cartNotifierHash() => r'27c8dc06b4f8a5479bcd3cff810a813b1ffeb3ce';

abstract class _$CartNotifier extends $AsyncNotifier<Cart?> {
  FutureOr<Cart?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Cart?>, Cart?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Cart?>, Cart?>,
              AsyncValue<Cart?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
