import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:driver_app/features/deliveries/data/data_sources/delivery_api_client.dart';
import 'package:driver_app/shared/providers/dio_provider.dart';

part 'delivery_providers.g.dart';

@riverpod
DeliveryApiClient deliveryApiClient(Ref ref) {
  final dio = ref.watch(dioProvider);
  const storage = FlutterSecureStorage();
  return DeliveryApiClient(dio: dio, storage: storage);
}

@riverpod
class AcceptDelivery extends _$AcceptDelivery {
  @override
  FutureOr<void> build() => null;

  Future<void> execute(String orderId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      return ref.read(deliveryApiClientProvider).acceptDelivery(orderId);
    });
  }
}
