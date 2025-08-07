// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translator_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranslatorResponseModel _$TranslatorResponseModelFromJson(
        Map<String, dynamic> json) =>
    TranslatorResponseModel(
      message: json['message'] as String?,
      translators: (json['translators'] as List<dynamic>?)
          ?.map(
              (e) => TranslatorProfileModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TranslatorResponseModelToJson(
        TranslatorResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'translators': instance.translators,
    };

TranslatorProfileModel _$TranslatorProfileModelFromJson(
        Map<String, dynamic> json) =>
    TranslatorProfileModel(
      profilePic: json['profilePic'] == null
          ? null
          : ProfilePic.fromJson(json['profilePic'] as Map<String, dynamic>),
      coverPic: json['coverPic'] == null
          ? null
          : CoverPic.fromJson(json['coverPic'] as Map<String, dynamic>),
      id: json['_id'] as String?,
      name: json['name'] as String?,
      gender: json['gender'] as String?,
      dob: json['DOB'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      age: json['age'] as num?,
      translator: (json['Translator'] as List<dynamic>?)
          ?.map((e) => Translator.fromJson(e as Map<String, dynamic>))
          .toList(),
      userId: json['id'] as String?,
    );

Map<String, dynamic> _$TranslatorProfileModelToJson(
        TranslatorProfileModel instance) =>
    <String, dynamic>{
      'profilePic': instance.profilePic,
      'coverPic': instance.coverPic,
      '_id': instance.id,
      'name': instance.name,
      'gender': instance.gender,
      'DOB': instance.dob,
      'mobileNumber': instance.mobileNumber,
      'age': instance.age,
      'Translator': instance.translator,
      'id': instance.userId,
    };

ProfilePic _$ProfilePicFromJson(Map<String, dynamic> json) => ProfilePic(
      publicId: json['public_id'] as String?,
      secureUrl: json['secure_url'] as String?,
    );

Map<String, dynamic> _$ProfilePicToJson(ProfilePic instance) =>
    <String, dynamic>{
      'public_id': instance.publicId,
      'secure_url': instance.secureUrl,
    };

CoverPic _$CoverPicFromJson(Map<String, dynamic> json) => CoverPic(
      publicId: json['public_id'] as String?,
      secureUrl: json['secure_url'] as String?,
    );

Map<String, dynamic> _$CoverPicToJson(CoverPic instance) => <String, dynamic>{
      'public_id': instance.publicId,
      'secure_url': instance.secureUrl,
    };

Translator _$TranslatorFromJson(Map<String, dynamic> json) => Translator(
      cv: json['cv'] == null
          ? null
          : Cv.fromJson(json['cv'] as Map<String, dynamic>),
      id: json['_id'] as String?,
      userId: json['userId'] as String?,
      language: (json['language'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      experienceYears: (json['experienceYears'] as num?)?.toInt(),
      bio: json['bio'] as String?,
      location: json['location'] as String?,
      availability: json['availability'] as bool?,
      type: (json['type'] as List<dynamic>?)?.map((e) => e as String).toList(),
      averageRating: json['averageRating'] as num?,
      numberOfRating: (json['numberOfRating'] as num?)?.toInt(),
      certifications: (json['certifications'] as List<dynamic>?)
          ?.map((e) => Certification.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TranslatorToJson(Translator instance) =>
    <String, dynamic>{
      'cv': instance.cv,
      '_id': instance.id,
      'userId': instance.userId,
      'language': instance.language,
      'experienceYears': instance.experienceYears,
      'bio': instance.bio,
      'location': instance.location,
      'availability': instance.availability,
      'type': instance.type,
      'averageRating': instance.averageRating,
      'numberOfRating': instance.numberOfRating,
      'certifications': instance.certifications,
    };

Cv _$CvFromJson(Map<String, dynamic> json) => Cv(
      publicId: json['public_id'] as String?,
      secureUrl: json['secure_url'] as String?,
    );

Map<String, dynamic> _$CvToJson(Cv instance) => <String, dynamic>{
      'public_id': instance.publicId,
      'secure_url': instance.secureUrl,
    };

Certification _$CertificationFromJson(Map<String, dynamic> json) =>
    Certification(
      publicId: json['public_id'] as String?,
      secureUrl: json['secure_url'] as String?,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$CertificationToJson(Certification instance) =>
    <String, dynamic>{
      'public_id': instance.publicId,
      'secure_url': instance.secureUrl,
      '_id': instance.id,
    };
