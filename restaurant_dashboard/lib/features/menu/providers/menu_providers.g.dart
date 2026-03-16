// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(menuApiClient)
final menuApiClientProvider = MenuApiClientProvider._();

final class MenuApiClientProvider
    extends $FunctionalProvider<MenuApiClient, MenuApiClient, MenuApiClient>
    with $Provider<MenuApiClient> {
  MenuApiClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'menuApiClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$menuApiClientHash();

  @$internal
  @override
  $ProviderElement<MenuApiClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MenuApiClient create(Ref ref) {
    return menuApiClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MenuApiClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MenuApiClient>(value),
    );
  }
}

String _$menuApiClientHash() => r'f7e9b7edb0c9e1877df5a2b8277367e20a353ad0';

@ProviderFor(menuRepository)
final menuRepositoryProvider = MenuRepositoryProvider._();

final class MenuRepositoryProvider
    extends $FunctionalProvider<MenuRepository, MenuRepository, MenuRepository>
    with $Provider<MenuRepository> {
  MenuRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'menuRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$menuRepositoryHash();

  @$internal
  @override
  $ProviderElement<MenuRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MenuRepository create(Ref ref) {
    return menuRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MenuRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MenuRepository>(value),
    );
  }
}

String _$menuRepositoryHash() => r'fe2498abf6c206622f7ae18e49de6a722f70198c';

@ProviderFor(MyRestaurantsController)
final myRestaurantsControllerProvider = MyRestaurantsControllerProvider._();

final class MyRestaurantsControllerProvider
    extends $AsyncNotifierProvider<MyRestaurantsController, List<Restaurant>> {
  MyRestaurantsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myRestaurantsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myRestaurantsControllerHash();

  @$internal
  @override
  MyRestaurantsController create() => MyRestaurantsController();
}

String _$myRestaurantsControllerHash() =>
    r'ef3d94180d5f2cfc28657bc58b7ceaeee791b470';

abstract class _$MyRestaurantsController
    extends $AsyncNotifier<List<Restaurant>> {
  FutureOr<List<Restaurant>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<Restaurant>>, List<Restaurant>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Restaurant>>, List<Restaurant>>,
              AsyncValue<List<Restaurant>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(MenuListController)
final menuListControllerProvider = MenuListControllerFamily._();

final class MenuListControllerProvider
    extends $AsyncNotifierProvider<MenuListController, List<MenuItem>> {
  MenuListControllerProvider._({
    required MenuListControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'menuListControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$menuListControllerHash();

  @override
  String toString() {
    return r'menuListControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  MenuListController create() => MenuListController();

  @override
  bool operator ==(Object other) {
    return other is MenuListControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$menuListControllerHash() =>
    r'8821ab099275251b65084b6e2195409d0ae1f09b';

final class MenuListControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          MenuListController,
          AsyncValue<List<MenuItem>>,
          List<MenuItem>,
          FutureOr<List<MenuItem>>,
          String
        > {
  MenuListControllerFamily._()
    : super(
        retry: null,
        name: r'menuListControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MenuListControllerProvider call(String restaurantId) =>
      MenuListControllerProvider._(argument: restaurantId, from: this);

  @override
  String toString() => r'menuListControllerProvider';
}

abstract class _$MenuListController extends $AsyncNotifier<List<MenuItem>> {
  late final _$args = ref.$arg as String;
  String get restaurantId => _$args;

  FutureOr<List<MenuItem>> build(String restaurantId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<MenuItem>>, List<MenuItem>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<MenuItem>>, List<MenuItem>>,
              AsyncValue<List<MenuItem>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
