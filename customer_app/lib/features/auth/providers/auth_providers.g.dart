// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authApiClient)
final authApiClientProvider = AuthApiClientProvider._();

final class AuthApiClientProvider
    extends $FunctionalProvider<AuthApiClient, AuthApiClient, AuthApiClient>
    with $Provider<AuthApiClient> {
  AuthApiClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authApiClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authApiClientHash();

  @$internal
  @override
  $ProviderElement<AuthApiClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthApiClient create(Ref ref) {
    return authApiClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthApiClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthApiClient>(value),
    );
  }
}

String _$authApiClientHash() => r'0dd201c62a91e3e95f875823df3507b295ecc66d';

@ProviderFor(authRepository)
final authRepositoryProvider = AuthRepositoryProvider._();

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  AuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepository create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepository>(value),
    );
  }
}

String _$authRepositoryHash() => r'ac9d53a66c6949cd6f8c564fb947b4cdff932764';

@ProviderFor(isAuthenticated)
final isAuthenticatedProvider = IsAuthenticatedProvider._();

final class IsAuthenticatedProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  IsAuthenticatedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isAuthenticatedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isAuthenticatedHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return isAuthenticated(ref);
  }
}

String _$isAuthenticatedHash() => r'b8ae0e35e32752b4fcdb1320b8243f9fa3caa3fa';

@ProviderFor(Login)
final loginProvider = LoginProvider._();

final class LoginProvider extends $AsyncNotifierProvider<Login, User?> {
  LoginProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loginProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loginHash();

  @$internal
  @override
  Login create() => Login();
}

String _$loginHash() => r'ede6f0cc18643116b9776150f04a4358671a6593';

abstract class _$Login extends $AsyncNotifier<User?> {
  FutureOr<User?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<User?>, User?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<User?>, User?>,
              AsyncValue<User?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(Register)
final registerProvider = RegisterProvider._();

final class RegisterProvider extends $AsyncNotifierProvider<Register, User?> {
  RegisterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registerHash();

  @$internal
  @override
  Register create() => Register();
}

String _$registerHash() => r'e1d33990ccd77030c2ca8bf3fc1386c9a4b8c0ed';

abstract class _$Register extends $AsyncNotifier<User?> {
  FutureOr<User?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<User?>, User?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<User?>, User?>,
              AsyncValue<User?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
