// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_email_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmEmailRequestBody _$ConfirmEmailRequestBodyFromJson(
        Map<String, dynamic> json) =>
    ConfirmEmailRequestBody(
      email: json['email'] as String,
      code: json['code'] as String,
    );

Map<String, dynamic> _$ConfirmEmailRequestBodyToJson(
        ConfirmEmailRequestBody instance) =>
    <String, dynamic>{
      'email': instance.email,
      'code': instance.code,
    };
