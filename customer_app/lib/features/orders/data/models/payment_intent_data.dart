class PaymentIntentData {
  const PaymentIntentData({
    required this.clientSecret,
    required this.paymentIntentId,
  });

  final String clientSecret;
  final String paymentIntentId;
}
