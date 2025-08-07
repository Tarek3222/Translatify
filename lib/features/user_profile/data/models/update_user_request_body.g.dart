// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserRequestBody _$UpdateUserRequestBodyFromJson(
        Map<String, dynamic> json) =>
    UpdateUserRequestBody(
      json['name'] as String,
      json['mobileNumber'] as String,
      json['DOB'] as String,
      json['gender'] as String,
    );

Map<String, dynamic> _$UpdateUserRequestBodyToJson(
        UpdateUserRequestBody instance) =>
    <String, dynamic>{
      'name': instance.name,
      'mobileNumber': instance.mobileNumber,
      'DOB': instance.dob,
      'gender': instance.gender,
    };
