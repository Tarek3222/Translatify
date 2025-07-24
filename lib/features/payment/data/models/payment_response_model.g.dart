// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentResponseModel _$PaymentResponseModelFromJson(
        Map<String, dynamic> json) =>
    PaymentResponseModel(
      date: json['date'] as String,
      time: json['time'] as String,
      totalSalary: (json['totalSalary'] as num).toDouble(),
      orderTranslator: OrderTranslatorModel.fromJson(
          json['orderTranslator'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentResponseModelToJson(
        PaymentResponseModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'time': instance.time,
      'totalSalary': instance.totalSalary,
      'orderTranslator': instance.orderTranslator,
    };
