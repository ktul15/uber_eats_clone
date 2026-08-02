// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(orderApiClient)
final orderApiClientProvider = OrderApiClientProvider._();

final class OrderApiClientProvider
    extends $FunctionalProvider<OrderApiClient, OrderApiClient, OrderApiClient>
    with $Provider<OrderApiClient> {
  OrderApiClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'orderApiClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$orderApiClientHash();

  @$internal
  @override
  $ProviderElement<OrderApiClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  OrderApiClient create(Ref ref) {
    return orderApiClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OrderApiClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OrderApiClient>(value),
    );
  }
}

String _$orderApiClientHash() => r'd2c79a31def08c94bea0a0a3557339066f7003ad';

@ProviderFor(PlaceOrder)
final placeOrderProvider = PlaceOrderProvider._();

final class PlaceOrderProvider
    extends $AsyncNotifierProvider<PlaceOrder, OrderDto?> {
  PlaceOrderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'placeOrderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$placeOrderHash();

  @$internal
  @override
  PlaceOrder create() => PlaceOrder();
}

String _$placeOrderHash() => r'e2c097f93038b445ce54d3e26d14d71950c75da9';

abstract class _$PlaceOrder extends $AsyncNotifier<OrderDto?> {
  FutureOr<OrderDto?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<OrderDto?>, OrderDto?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<OrderDto?>, OrderDto?>,
              AsyncValue<OrderDto?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(CreatePaymentIntent)
final createPaymentIntentProvider = CreatePaymentIntentProvider._();

final class CreatePaymentIntentProvider
    extends $AsyncNotifierProvider<CreatePaymentIntent, String?> {
  CreatePaymentIntentProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createPaymentIntentProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createPaymentIntentHash();

  @$internal
  @override
  CreatePaymentIntent create() => CreatePaymentIntent();
}

String _$createPaymentIntentHash() =>
    r'82c0cf825c80c583c4870cbb0a62f77e37050617';

abstract class _$CreatePaymentIntent extends $AsyncNotifier<String?> {
  FutureOr<String?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<String?>, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String?>, String?>,
              AsyncValue<String?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(orderHistory)
final orderHistoryProvider = OrderHistoryProvider._();

final class OrderHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<OrderDto>>,
          List<OrderDto>,
          FutureOr<List<OrderDto>>
        >
    with $FutureModifier<List<OrderDto>>, $FutureProvider<List<OrderDto>> {
  OrderHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'orderHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$orderHistoryHash();

  @$internal
  @override
  $FutureProviderElement<List<OrderDto>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<OrderDto>> create(Ref ref) {
    return orderHistory(ref);
  }
}

String _$orderHistoryHash() => r'4fe8951082d84d13b02ca01a8050cbcfb7d2e5dd';

@ProviderFor(SubmitReview)
final submitReviewProvider = SubmitReviewFamily._();

final class SubmitReviewProvider
    extends $AsyncNotifierProvider<SubmitReview, OrderDto?> {
  SubmitReviewProvider._({
    required SubmitReviewFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'submitReviewProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$submitReviewHash();

  @override
  String toString() {
    return r'submitReviewProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SubmitReview create() => SubmitReview();

  @override
  bool operator ==(Object other) {
    return other is SubmitReviewProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$submitReviewHash() => r'4c2916fad8f70f75df1bd0fb6377bd6b81f6d230';

final class SubmitReviewFamily extends $Family
    with
        $ClassFamilyOverride<
          SubmitReview,
          AsyncValue<OrderDto?>,
          OrderDto?,
          FutureOr<OrderDto?>,
          String
        > {
  SubmitReviewFamily._()
    : super(
        retry: null,
        name: r'submitReviewProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SubmitReviewProvider call(String orderId) =>
      SubmitReviewProvider._(argument: orderId, from: this);

  @override
  String toString() => r'submitReviewProvider';
}

abstract class _$SubmitReview extends $AsyncNotifier<OrderDto?> {
  late final _$args = ref.$arg as String;
  String get orderId => _$args;

  FutureOr<OrderDto?> build(String orderId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<OrderDto?>, OrderDto?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<OrderDto?>, OrderDto?>,
              AsyncValue<OrderDto?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
