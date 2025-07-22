// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    UserProfileModel(
      message: json['message'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserProfileModelToJson(UserProfileModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'user': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      profilePic: json['profilePic'] == null
          ? null
          : ProfilePic.fromJson(json['profilePic'] as Map<String, dynamic>),
      coverPic: json['coverPic'] == null
          ? null
          : CoverPic.fromJson(json['coverPic'] as Map<String, dynamic>),
      id: json['_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      provider: json['provider'] as String?,
      gender: json['gender'] as String?,
      dob: json['DOB'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      role: json['role'] as String?,
      isTranslator: json['isTranslator'] as bool?,
      isVerified: json['isVerified'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
      mediaCloudFolder: json['mediaCloudFolder'] as String?,
      companyOwnered: json['companyOwnered'] as List<dynamic>?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      age: (json['age'] as num?)?.toInt(),
      translator: json['Translator'] as List<dynamic>?,
      userId: json['id'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'profilePic': instance.profilePic,
      'coverPic': instance.coverPic,
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'provider': instance.provider,
      'gender': instance.gender,
      'DOB': instance.dob,
      'mobileNumber': instance.mobileNumber,
      'role': instance.role,
      'isTranslator': instance.isTranslator,
      'isVerified': instance.isVerified,
      'isDeleted': instance.isDeleted,
      'mediaCloudFolder': instance.mediaCloudFolder,
      'companyOwnered': instance.companyOwnered,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
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
