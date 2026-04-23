import 'package:restaurant_dashboard/features/orders/data/data_sources/order_api_client.dart';
import 'package:restaurant_dashboard/features/orders/data/models/order_dto.dart';

class OrderRepository {
  final OrderApiClient _apiClient;

  OrderRepository({required OrderApiClient apiClient}) : _apiClient = apiClient;

  Future<List<OrderDto>> getOrders() => _apiClient.getOrders();

  Future<OrderDto> updateOrderStatus(String orderId, String status) =>
      _apiClient.updateOrderStatus(orderId, status);
}
