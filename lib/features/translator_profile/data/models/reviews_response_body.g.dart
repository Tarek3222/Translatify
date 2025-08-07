// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews_response_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewsResponseBody _$ReviewsResponseBodyFromJson(Map<String, dynamic> json) =>
    ReviewsResponseBody(
      message: json['message'] as String?,
      reviewsCount: (json['reviewsCount'] as num?)?.toInt(),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReviewsResponseBodyToJson(
        ReviewsResponseBody instance) =>
    <String, dynamic>{
      'message': instance.message,
      'reviewsCount': instance.reviewsCount,
      'reviews': instance.reviews,
    };

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
      id: json['_id'] as String?,
      reviewerId: json['reviewerId'] == null
          ? null
          : ReviewerId.fromJson(json['reviewerId'] as Map<String, dynamic>),
      reviewedUserId: json['reviewedUserId'] as String?,
      rating: json['rating'] as num?,
      comment: json['comment'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'reviewerId': instance.reviewerId,
      'reviewedUserId': instance.reviewedUserId,
      'rating': instance.rating,
      'comment': instance.comment,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
    };

ReviewerId _$ReviewerIdFromJson(Map<String, dynamic> json) => ReviewerId(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      age: json['age'] as num?,
    );

Map<String, dynamic> _$ReviewerIdToJson(ReviewerId instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'age': instance.age,
    };
