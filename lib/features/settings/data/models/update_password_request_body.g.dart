// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_password_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePasswordRequestBody _$UpdatePasswordRequestBodyFromJson(
        Map<String, dynamic> json) =>
    UpdatePasswordRequestBody(
      currentPassword: json['currentPassword'] as String,
      newPassword: json['newPassword'] as String,
      confirmNewPassword: json['confirmNewPassword'] as String,
    );

Map<String, dynamic> _$UpdatePasswordRequestBodyToJson(
        UpdatePasswordRequestBody instance) =>
    <String, dynamic>{
      'currentPassword': instance.currentPassword,
      'newPassword': instance.newPassword,
      'confirmNewPassword': instance.confirmNewPassword,
    };
