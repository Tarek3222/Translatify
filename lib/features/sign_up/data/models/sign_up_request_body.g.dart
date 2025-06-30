// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpRequestBody _$SignUpRequestBodyFromJson(Map<String, dynamic> json) =>
    SignUpRequestBody(
      email: json['email'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
      confirmPassword: json['confirmPassword'] as String,
      mobileNumber: json['mobileNumber'] as String,
      dateOfBirth: json['DOB'] as String,
      gender: json['gender'] as String,
    );

Map<String, dynamic> _$SignUpRequestBodyToJson(SignUpRequestBody instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
      'mobileNumber': instance.mobileNumber,
      'DOB': instance.dateOfBirth,
      'gender': instance.gender,
    };
