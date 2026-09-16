import 'package:dio/dio.dart';
import 'package:customer_app/features/orders/data/models/order_dto.dart';
import 'package:customer_app/features/orders/data/models/payment_intent_data.dart';

class OrderApiClient {
  final Dio _dio;

  OrderApiClient(this._dio);

  Future<PaymentIntentData> createPaymentIntent() async {
    final response = await _dio.post('/api/orders/payment-intent');
    final data =
        (response.data as Map<String, dynamic>)['data'] as Map<String, dynamic>;
    return PaymentIntentData(
      clientSecret: data['clientSecret'] as String,
      paymentIntentId: data['paymentIntentId'] as String,
    );
  }

  Future<OrderDto> placeOrder({
    required String deliveryAddress,
    required String paymentIntentId,
  }) async {
    final response = await _dio.post(
      '/api/orders',
      data: {
        'deliveryAddress': deliveryAddress,
        'paymentIntentId': paymentIntentId,
      },
    );
    return OrderDto.fromJson(
      (response.data as Map<String, dynamic>)['data'] as Map<String, dynamic>,
    );
  }

  Future<List<OrderDto>> getOrders() async {
    final response = await _dio.get('/api/orders');
    final data = (response.data as Map<String, dynamic>)['data'] as List;
    return data
        .map((item) => OrderDto.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<OrderDto> getOrderById(String orderId) async {
    final response = await _dio.get('/api/orders/$orderId');
    return OrderDto.fromJson(
      (response.data as Map<String, dynamic>)['data'] as Map<String, dynamic>,
    );
  }

  Future<Map<String, dynamic>?> getDeliveryForOrder(String orderId) async {
    final response = await _dio.get('/api/deliveries/order/$orderId');
    final data = (response.data as Map<String, dynamic>)['data'];
    return data == null ? null : Map<String, dynamic>.from(data as Map);
  }

  Future<OrderDto> submitReview({
    required String orderId,
    required int rating,
    String? comment,
  }) async {
    final response = await _dio.post(
      '/api/orders/$orderId/review',
      data: {
        'rating': rating,
        if (comment != null && comment.trim().isNotEmpty)
          'comment': comment.trim(),
      },
    );
    return OrderDto.fromJson(
      (response.data as Map<String, dynamic>)['data'] as Map<String, dynamic>,
    );
  }
}
