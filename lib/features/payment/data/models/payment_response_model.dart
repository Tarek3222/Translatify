import 'package:json_annotation/json_annotation.dart';
import 'package:translators/features/translator_profile/data/models/order_translator_model.dart';

part 'payment_response_model.g.dart';

@JsonSerializable()
class PaymentResponseModel {
  final String date;
  final String time;
  final double totalSalary;
  final OrderTranslatorModel orderTranslator;

  PaymentResponseModel({
    required this.date,
    required this.time,
    required this.totalSalary,
    required this.orderTranslator,
  });

  factory PaymentResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentResponseModelToJson(this);
}
