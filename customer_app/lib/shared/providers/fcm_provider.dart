import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:customer_app/shared/providers/dio_provider.dart';
import 'package:customer_app/shared/services/fcm_api_client.dart';

part 'fcm_provider.g.dart';

@riverpod
FcmApiClient fcmApiClient(Ref ref) {
  final dio = ref.watch(dioProvider);
  const storage = FlutterSecureStorage();
  return FcmApiClient(dio: dio, storage: storage);
}
