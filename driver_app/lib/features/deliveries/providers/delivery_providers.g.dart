// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deliveryApiClient)
final deliveryApiClientProvider = DeliveryApiClientProvider._();

final class DeliveryApiClientProvider
    extends
        $FunctionalProvider<
          DeliveryApiClient,
          DeliveryApiClient,
          DeliveryApiClient
        >
    with $Provider<DeliveryApiClient> {
  DeliveryApiClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deliveryApiClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deliveryApiClientHash();

  @$internal
  @override
  $ProviderElement<DeliveryApiClient> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeliveryApiClient create(Ref ref) {
    return deliveryApiClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeliveryApiClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeliveryApiClient>(value),
    );
  }
}

String _$deliveryApiClientHash() => r'9d9ba8c6530d027a3f86863e3a418a7688285d3b';

@ProviderFor(AcceptDelivery)
final acceptDeliveryProvider = AcceptDeliveryProvider._();

final class AcceptDeliveryProvider
    extends $AsyncNotifierProvider<AcceptDelivery, void> {
  AcceptDeliveryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'acceptDeliveryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$acceptDeliveryHash();

  @$internal
  @override
  AcceptDelivery create() => AcceptDelivery();
}

String _$acceptDeliveryHash() => r'd9ddfbe473cff80ffbe1f2602eaa1e1a1f25655a';

abstract class _$AcceptDelivery extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(activeDelivery)
final activeDeliveryProvider = ActiveDeliveryProvider._();

final class ActiveDeliveryProvider
    extends
        $FunctionalProvider<
          AsyncValue<ActiveDelivery?>,
          ActiveDelivery?,
          FutureOr<ActiveDelivery?>
        >
    with $FutureModifier<ActiveDelivery?>, $FutureProvider<ActiveDelivery?> {
  ActiveDeliveryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeDeliveryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeDeliveryHash();

  @$internal
  @override
  $FutureProviderElement<ActiveDelivery?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ActiveDelivery?> create(Ref ref) {
    return activeDelivery(ref);
  }
}

String _$activeDeliveryHash() => r'729a0c55bbc3a5c2a097c968cbae4081e0929aa6';

@ProviderFor(UpdateDeliveryStatus)
final updateDeliveryStatusProvider = UpdateDeliveryStatusProvider._();

final class UpdateDeliveryStatusProvider
    extends $AsyncNotifierProvider<UpdateDeliveryStatus, void> {
  UpdateDeliveryStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateDeliveryStatusProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateDeliveryStatusHash();

  @$internal
  @override
  UpdateDeliveryStatus create() => UpdateDeliveryStatus();
}

String _$updateDeliveryStatusHash() =>
    r'ad5f983c9d80d70685abacba721a144686590f40';

abstract class _$UpdateDeliveryStatus extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
