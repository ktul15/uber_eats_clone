import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:restaurant_dashboard/shared/providers/dio_provider.dart';
import 'package:restaurant_dashboard/shared/services/fcm_api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fcm_provider.g.dart';

@riverpod
FcmApiClient fcmApiClient(Ref ref) => FcmApiClient(
  dio: ref.watch(dioProvider),
  storage: const FlutterSecureStorage(),
);
