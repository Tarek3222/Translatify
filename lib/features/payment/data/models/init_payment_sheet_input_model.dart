class InitPaymentSheetInputModel {
  final String paymentIntentClientSecret;
  final String merchantDisplayName;
  final String ephemeralKeySecret;
  final String? customerId;

  const InitPaymentSheetInputModel({
    required this.paymentIntentClientSecret,
    required this.merchantDisplayName,
    required this.ephemeralKeySecret,
    this.customerId,
  });
}
