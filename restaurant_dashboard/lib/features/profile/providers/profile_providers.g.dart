// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(profileApiClient)
final profileApiClientProvider = ProfileApiClientProvider._();

final class ProfileApiClientProvider
    extends
        $FunctionalProvider<
          ProfileApiClient,
          ProfileApiClient,
          ProfileApiClient
        >
    with $Provider<ProfileApiClient> {
  ProfileApiClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileApiClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileApiClientHash();

  @$internal
  @override
  $ProviderElement<ProfileApiClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ProfileApiClient create(Ref ref) {
    return profileApiClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfileApiClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfileApiClient>(value),
    );
  }
}

String _$profileApiClientHash() => r'babbc334c9ee44f6fb2a38f2cff1f1f328d92d73';

@ProviderFor(profileRepository)
final profileRepositoryProvider = ProfileRepositoryProvider._();

final class ProfileRepositoryProvider
    extends
        $FunctionalProvider<
          ProfileRepository,
          ProfileRepository,
          ProfileRepository
        >
    with $Provider<ProfileRepository> {
  ProfileRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileRepositoryHash();

  @$internal
  @override
  $ProviderElement<ProfileRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProfileRepository create(Ref ref) {
    return profileRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfileRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfileRepository>(value),
    );
  }
}

String _$profileRepositoryHash() => r'79fd974e2df1527711aab8002ddf2f46b4d9deaf';

@ProviderFor(ProfileController)
final profileControllerProvider = ProfileControllerProvider._();

final class ProfileControllerProvider
    extends $AsyncNotifierProvider<ProfileController, UserProfile?> {
  ProfileControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileControllerHash();

  @$internal
  @override
  ProfileController create() => ProfileController();
}

String _$profileControllerHash() => r'e5f5429bc16e10b4bddb96efb0961da1c878b47a';

abstract class _$ProfileController extends $AsyncNotifier<UserProfile?> {
  FutureOr<UserProfile?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<UserProfile?>, UserProfile?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UserProfile?>, UserProfile?>,
              AsyncValue<UserProfile?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
