import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:customer_app/features/auth/data/data_sources/auth_api_client.dart';
import 'package:customer_app/features/auth/domain/models/user.dart';
import 'package:customer_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:customer_app/shared/providers/dio_provider.dart';
import 'package:customer_app/shared/providers/fcm_provider.dart';
import 'package:customer_app/features/orders/providers/order_providers.dart';

part 'auth_providers.g.dart';

Future<void> _registerFcmToken(Ref ref) async {
  final token = await FirebaseMessaging.instance.getToken();
  if (token != null) await ref.read(fcmApiClientProvider).registerToken(token);
}

Future<void> bestEffortFcmUnregister({
  required Future<String?> Function() getToken,
  required Future<void> Function(String token) removeToken,
}) async {
  try {
    final token = await getToken();
    if (token != null) await removeToken(token);
  } catch (_) {}
}

// --- Infrastructure Providers ---

@riverpod
AuthApiClient authApiClient(Ref ref) {
  final dio = ref.watch(dioProvider);
  return AuthApiClient(dio);
}

@riverpod
AuthRepository authRepository(Ref ref) {
  final apiClient = ref.watch(authApiClientProvider);
  const storage = FlutterSecureStorage();
  return AuthRepository(apiClient: apiClient, storage: storage);
}

// --- Auth State ---

@riverpod
Future<bool> isAuthenticated(Ref ref) async {
  final repo = ref.watch(authRepositoryProvider);
  return repo.isAuthenticated();
}

// --- Login ---

@riverpod
class Login extends _$Login {
  @override
  FutureOr<User?> build() => null;

  Future<void> execute({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      final repo = ref.read(authRepositoryProvider);
      return repo.login(email: email, password: password);
    });
    if (state.hasValue && state.value != null) {
      ref.invalidate(isAuthenticatedProvider);
      unawaited(_registerFcmToken(ref));
    }
  }
}

// --- Register ---

@riverpod
class Register extends _$Register {
  @override
  FutureOr<User?> build() => null;

  Future<void> execute({
    required String email,
    required String password,
    required String name,
    String? phone,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      final repo = ref.read(authRepositoryProvider);
      return repo.register(
        email: email,
        password: password,
        name: name,
        phone: phone,
      );
    });
    if (state.hasValue && state.value != null) {
      ref.invalidate(isAuthenticatedProvider);
      unawaited(_registerFcmToken(ref));
    }
  }
}

@riverpod
class Logout extends _$Logout {
  @override
  FutureOr<void> build() => null;

  Future<void> execute() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      try {
        await bestEffortFcmUnregister(
          getToken: FirebaseMessaging.instance.getToken,
          removeToken: ref.read(fcmApiClientProvider).removeToken,
        );
      } finally {
        await ref.read(checkoutSessionStorageProvider).clearActive();
        await ref.read(authRepositoryProvider).logout();
        ref.invalidate(isAuthenticatedProvider);
      }
    });
  }
}
