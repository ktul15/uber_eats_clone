import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:driver_app/features/profile/data/data_sources/profile_api_client.dart';
import 'package:driver_app/features/profile/domain/models/user_profile.dart';
import 'package:driver_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:driver_app/shared/providers/dio_provider.dart';

part 'profile_providers.g.dart';

// --- Infrastructure ---
@riverpod
ProfileApiClient profileApiClient(Ref ref) {
  final dio = ref.watch(dioProvider);
  const storage = FlutterSecureStorage();
  return ProfileApiClient(dio: dio, storage: storage);
}

@riverpod
ProfileRepository profileRepository(Ref ref) {
  final apiClient = ref.watch(profileApiClientProvider);
  return ProfileRepository(apiClient: apiClient);
}

// --- State ---
@riverpod
class ProfileController extends _$ProfileController {
  @override
  FutureOr<UserProfile?> build() async {
    final repo = ref.watch(profileRepositoryProvider);
    return repo.getProfile();
  }

  Future<void> updateProfile({
    String? name,
    String? phone,
    String? vehicleType,
    String? licenseNumber,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      final repo = ref.read(profileRepositoryProvider);
      return repo.updateProfile(
        name: name,
        phone: phone,
        vehicleType: vehicleType,
        licenseNumber: licenseNumber,
      );
    });
  }
}
