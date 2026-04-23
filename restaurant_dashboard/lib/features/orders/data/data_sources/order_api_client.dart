import 'package:dio/dio.dart';
import 'package:restaurant_dashboard/features/orders/data/models/order_dto.dart';

class OrderApiClient {
  final Dio _dio;

  OrderApiClient(this._dio);

  Future<List<OrderDto>> getOrders() async {
    final response = await _dio.get('/api/orders');
    final data = (response.data as Map<String, dynamic>)['data'] as List;
    return data.map((e) => OrderDto.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<OrderDto> updateOrderStatus(String orderId, String status) async {
    final response = await _dio.patch(
      '/api/orders/$orderId/status',
      data: {'status': status},
    );
    return OrderDto.fromJson(
      (response.data as Map<String, dynamic>)['data'] as Map<String, dynamic>,
    );
  }
}
