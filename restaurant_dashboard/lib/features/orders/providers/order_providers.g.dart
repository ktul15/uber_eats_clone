// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(orderApiClient)
final orderApiClientProvider = OrderApiClientProvider._();

final class OrderApiClientProvider
    extends $FunctionalProvider<OrderApiClient, OrderApiClient, OrderApiClient>
    with $Provider<OrderApiClient> {
  OrderApiClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'orderApiClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$orderApiClientHash();

  @$internal
  @override
  $ProviderElement<OrderApiClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  OrderApiClient create(Ref ref) {
    return orderApiClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OrderApiClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OrderApiClient>(value),
    );
  }
}

String _$orderApiClientHash() => r'd2c79a31def08c94bea0a0a3557339066f7003ad';

@ProviderFor(orderRepository)
final orderRepositoryProvider = OrderRepositoryProvider._();

final class OrderRepositoryProvider
    extends
        $FunctionalProvider<OrderRepository, OrderRepository, OrderRepository>
    with $Provider<OrderRepository> {
  OrderRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'orderRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$orderRepositoryHash();

  @$internal
  @override
  $ProviderElement<OrderRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  OrderRepository create(Ref ref) {
    return orderRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OrderRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OrderRepository>(value),
    );
  }
}

String _$orderRepositoryHash() => r'54176c1baf23bb93b5f5b55f35261db98791b334';

@ProviderFor(ActiveOrdersController)
final activeOrdersControllerProvider = ActiveOrdersControllerProvider._();

final class ActiveOrdersControllerProvider
    extends $AsyncNotifierProvider<ActiveOrdersController, List<OrderDto>> {
  ActiveOrdersControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeOrdersControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeOrdersControllerHash();

  @$internal
  @override
  ActiveOrdersController create() => ActiveOrdersController();
}

String _$activeOrdersControllerHash() =>
    r'89c78e95f4c0f512e02ac951e2f08f32bc61d2b1';

abstract class _$ActiveOrdersController extends $AsyncNotifier<List<OrderDto>> {
  FutureOr<List<OrderDto>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<OrderDto>>, List<OrderDto>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<OrderDto>>, List<OrderDto>>,
              AsyncValue<List<OrderDto>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
