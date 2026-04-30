import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:driver_app/features/deliveries/data/models/active_delivery_dto.dart';
import 'package:driver_app/shared/constants/api_constants.dart';

class DeliveryApiClient {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  static const _tokenKey = 'auth_token';

  DeliveryApiClient({required Dio dio, required FlutterSecureStorage storage})
      : _dio = dio,
        _storage = storage;

  Future<Options> _authOptions() async {
    final token = await _storage.read(key: _tokenKey);
    return Options(headers: {'Authorization': 'Bearer $token'});
  }

  Future<void> acceptDelivery(String orderId) async {
    final options = await _authOptions();
    await _dio.post(
      ApiConstants.acceptDelivery,
      data: {'orderId': orderId},
      options: options,
    );
  }

  Future<ActiveDeliveryDto?> getActiveDelivery() async {
    final options = await _authOptions();
    final response = await _dio.get(ApiConstants.activeDelivery, options: options);
    final data = (response.data as Map<String, dynamic>)['data'];
    if (data == null) return null;
    return ActiveDeliveryDto.fromJson(data as Map<String, dynamic>);
  }

  Future<void> updateDeliveryStatus(String deliveryId, String status) async {
    final options = await _authOptions();
    await _dio.patch(
      ApiConstants.updateDeliveryStatus(deliveryId),
      data: {'status': status},
      options: options,
    );
  }

  Future<void> updateLocation(String deliveryId, double lat, double lng) async {
    final options = await _authOptions();
    await _dio.patch(
      ApiConstants.updateDeliveryLocation(deliveryId),
      data: {'lat': lat, 'lng': lng},
      options: options,
    );
  }
}
