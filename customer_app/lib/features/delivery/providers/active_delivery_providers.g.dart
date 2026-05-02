// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_delivery_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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
    r'6db5e2d041213e95c2cb38aeb2599d93ab97d227';

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
