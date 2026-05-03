// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fcmApiClient)
final fcmApiClientProvider = FcmApiClientProvider._();

final class FcmApiClientProvider
    extends $FunctionalProvider<FcmApiClient, FcmApiClient, FcmApiClient>
    with $Provider<FcmApiClient> {
  FcmApiClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fcmApiClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fcmApiClientHash();

  @$internal
  @override
  $ProviderElement<FcmApiClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FcmApiClient create(Ref ref) {
    return fcmApiClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FcmApiClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FcmApiClient>(value),
    );
  }
}

String _$fcmApiClientHash() => r'e125002b7cfc2e262338b671e24bb34bc2737dba';
