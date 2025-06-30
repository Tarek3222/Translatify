// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInRequestBody _$SignInRequestBodyFromJson(Map<String, dynamic> json) =>
    SignInRequestBody(
      password: json['password'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$SignInRequestBodyToJson(SignInRequestBody instance) =>
    <String, dynamic>{
      'password': instance.password,
      'email': instance.email,
    };
