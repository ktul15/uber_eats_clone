// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LocationTracker)
final locationTrackerProvider = LocationTrackerProvider._();

final class LocationTrackerProvider
    extends $NotifierProvider<LocationTracker, void> {
  LocationTrackerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationTrackerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$locationTrackerHash();

  @$internal
  @override
  LocationTracker create() => LocationTracker();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$locationTrackerHash() => r'f61f65bfed76bf03b8f7e3ab778eb03a6a99f067';

abstract class _$LocationTracker extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
