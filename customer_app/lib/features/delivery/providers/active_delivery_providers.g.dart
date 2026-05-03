// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_delivery_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(directionsService)
final directionsServiceProvider = DirectionsServiceProvider._();

final class DirectionsServiceProvider
    extends
        $FunctionalProvider<
          DirectionsService,
          DirectionsService,
          DirectionsService
        >
    with $Provider<DirectionsService> {
  DirectionsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'directionsServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$directionsServiceHash();

  @$internal
  @override
  $ProviderElement<DirectionsService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DirectionsService create(Ref ref) {
    return directionsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DirectionsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DirectionsService>(value),
    );
  }
}

String _$directionsServiceHash() => r'234020d264f059b632f17518baa051e420d2c8c6';

@ProviderFor(ActiveDeliveryNotifier)
final activeDeliveryProvider = ActiveDeliveryNotifierFamily._();

final class ActiveDeliveryNotifierProvider
    extends $NotifierProvider<ActiveDeliveryNotifier, ActiveDeliveryState> {
  ActiveDeliveryNotifierProvider._({
    required ActiveDeliveryNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'activeDeliveryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$activeDeliveryNotifierHash();

  @override
  String toString() {
    return r'activeDeliveryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ActiveDeliveryNotifier create() => ActiveDeliveryNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ActiveDeliveryState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ActiveDeliveryState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ActiveDeliveryNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$activeDeliveryNotifierHash() =>
    r'0cd909a2f2f5552f4d7788c47a0b24ddd1b68cef';

final class ActiveDeliveryNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ActiveDeliveryNotifier,
          ActiveDeliveryState,
          ActiveDeliveryState,
          ActiveDeliveryState,
          String
        > {
  ActiveDeliveryNotifierFamily._()
    : super(
        retry: null,
        name: r'activeDeliveryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ActiveDeliveryNotifierProvider call(String orderId) =>
      ActiveDeliveryNotifierProvider._(argument: orderId, from: this);

  @override
  String toString() => r'activeDeliveryProvider';
}

abstract class _$ActiveDeliveryNotifier extends $Notifier<ActiveDeliveryState> {
  late final _$args = ref.$arg as String;
  String get orderId => _$args;

  ActiveDeliveryState build(String orderId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ActiveDeliveryState, ActiveDeliveryState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ActiveDeliveryState, ActiveDeliveryState>,
              ActiveDeliveryState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
