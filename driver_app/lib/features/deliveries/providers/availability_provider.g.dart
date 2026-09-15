// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'availability_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DriverAvailability)
final driverAvailabilityProvider = DriverAvailabilityProvider._();

final class DriverAvailabilityProvider
    extends $AsyncNotifierProvider<DriverAvailability, AvailabilityStatus> {
  DriverAvailabilityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driverAvailabilityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driverAvailabilityHash();

  @$internal
  @override
  DriverAvailability create() => DriverAvailability();
}

String _$driverAvailabilityHash() =>
    r'2924305ea9c67b981245c0c1514abb2c57055953';

abstract class _$DriverAvailability extends $AsyncNotifier<AvailabilityStatus> {
  FutureOr<AvailabilityStatus> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<AvailabilityStatus>, AvailabilityStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AvailabilityStatus>, AvailabilityStatus>,
              AsyncValue<AvailabilityStatus>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
