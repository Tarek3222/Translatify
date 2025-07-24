// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_translator_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderTranslatorModel _$OrderTranslatorModelFromJson(
        Map<String, dynamic> json) =>
    OrderTranslatorModel(
      isPaid: json['isPaid'] as bool? ?? false,
      translatorProfileModel: TranslatorProfileModel.fromJson(
          json['translatorProfileModel'] as Map<String, dynamic>),
      currency: json['currency'] as String,
      durationInHours: (json['durationInHours'] as num).toInt(),
      date: json['date'] as String,
      time: json['time'] as String,
      coupon: json['coupon'] as String?,
      salary: (json['salary'] as num).toDouble(),
    );

Map<String, dynamic> _$OrderTranslatorModelToJson(
        OrderTranslatorModel instance) =>
    <String, dynamic>{
      'translatorProfileModel': instance.translatorProfileModel,
      'currency': instance.currency,
      'durationInHours': instance.durationInHours,
      'date': instance.date,
      'time': instance.time,
      'coupon': instance.coupon,
      'salary': instance.salary,
      'isPaid': instance.isPaid,
    };
