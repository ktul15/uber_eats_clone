import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:driver_app/features/auth/data/data_sources/auth_api_client.dart';
import 'package:driver_app/features/auth/domain/models/user.dart';
import 'package:driver_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:driver_app/shared/providers/dio_provider.dart';

part 'auth_providers.g.dart';

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
    String? vehicleType,
    String? licenseNumber,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      final repo = ref.read(authRepositoryProvider);
      return repo.register(
        email: email,
        password: password,
        name: name,
        phone: phone,
        vehicleType: vehicleType,
        licenseNumber: licenseNumber,
      );
    });
    if (state.hasValue && state.value != null) {
      ref.invalidate(isAuthenticatedProvider);
    }
  }
}
