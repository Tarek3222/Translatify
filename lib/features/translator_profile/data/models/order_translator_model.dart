import 'package:json_annotation/json_annotation.dart';
import 'package:translator/features/home/data/models/translator_response_model.dart';

part 'order_translator_model.g.dart';

@JsonSerializable()
class OrderTranslatorModel {
  final TranslatorProfileModel translatorProfileModel;
  final String currency;
  final int durationInHours;
  final String date;
  final String time;
  final String? coupon;
  final double salary;

  OrderTranslatorModel({
    required this.translatorProfileModel,
    required this.currency,
    required this.durationInHours,
    required this.date,
    required this.time,
    this.coupon,
    required this.salary,
  });

  factory OrderTranslatorModel.fromJson(Map<String, dynamic> json) =>
      _$OrderTranslatorModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderTranslatorModelToJson(this);
}
