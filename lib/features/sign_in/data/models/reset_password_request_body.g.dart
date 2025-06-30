// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPasswordRequestBody _$ResetPasswordRequestBodyFromJson(
        Map<String, dynamic> json) =>
    ResetPasswordRequestBody(
      password: json['password'] as String,
      confirmOtp: json['confirmOtp'] as String,
      confirmPassword: json['confirmPassword'] as String,
    );

Map<String, dynamic> _$ResetPasswordRequestBodyToJson(
        ResetPasswordRequestBody instance) =>
    <String, dynamic>{
      'password': instance.password,
      'confirmOtp': instance.confirmOtp,
      'confirmPassword': instance.confirmPassword,
    };
