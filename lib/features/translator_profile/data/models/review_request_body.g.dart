// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewRequestBody _$ReviewRequestBodyFromJson(Map<String, dynamic> json) =>
    ReviewRequestBody(
      rating: json['rating'] as num,
      comment: json['comment'] as String,
    );

Map<String, dynamic> _$ReviewRequestBodyToJson(ReviewRequestBody instance) =>
    <String, dynamic>{
      'rating': instance.rating,
      'comment': instance.comment,
    };
