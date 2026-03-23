// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(restaurantApiClient)
final restaurantApiClientProvider = RestaurantApiClientProvider._();

final class RestaurantApiClientProvider
    extends
        $FunctionalProvider<
          RestaurantApiClient,
          RestaurantApiClient,
          RestaurantApiClient
        >
    with $Provider<RestaurantApiClient> {
  RestaurantApiClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'restaurantApiClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$restaurantApiClientHash();

  @$internal
  @override
  $ProviderElement<RestaurantApiClient> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RestaurantApiClient create(Ref ref) {
    return restaurantApiClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RestaurantApiClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RestaurantApiClient>(value),
    );
  }
}

String _$restaurantApiClientHash() =>
    r'a433668bb602aad90ab7a25b90780a570c3e9836';

@ProviderFor(restaurantRepository)
final restaurantRepositoryProvider = RestaurantRepositoryProvider._();

final class RestaurantRepositoryProvider
    extends
        $FunctionalProvider<
          RestaurantRepository,
          RestaurantRepository,
          RestaurantRepository
        >
    with $Provider<RestaurantRepository> {
  RestaurantRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'restaurantRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$restaurantRepositoryHash();

  @$internal
  @override
  $ProviderElement<RestaurantRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RestaurantRepository create(Ref ref) {
    return restaurantRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RestaurantRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RestaurantRepository>(value),
    );
  }
}

String _$restaurantRepositoryHash() =>
    r'9ff504493dd8131a4536db48ef218fad9ae09751';

@ProviderFor(SearchQuery)
final searchQueryProvider = SearchQueryProvider._();

final class SearchQueryProvider extends $NotifierProvider<SearchQuery, String> {
  SearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchQueryHash();

  @$internal
  @override
  SearchQuery create() => SearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$searchQueryHash() => r'286abcff51dc844febe02639bb2e883ccab22cfd';

abstract class _$SearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(restaurantList)
final restaurantListProvider = RestaurantListProvider._();

final class RestaurantListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Restaurant>>,
          List<Restaurant>,
          FutureOr<List<Restaurant>>
        >
    with $FutureModifier<List<Restaurant>>, $FutureProvider<List<Restaurant>> {
  RestaurantListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'restaurantListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$restaurantListHash();

  @$internal
  @override
  $FutureProviderElement<List<Restaurant>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Restaurant>> create(Ref ref) {
    return restaurantList(ref);
  }
}

String _$restaurantListHash() => r'bd3d4a90da7cd7139e56422875d98e813e26729d';
