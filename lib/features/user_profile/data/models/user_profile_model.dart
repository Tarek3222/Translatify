import 'package:json_annotation/json_annotation.dart';

part 'user_profile_model.g.dart';

@JsonSerializable()
class UserProfileModel {
  final String? message;
  final User? user;

  UserProfileModel({
    this.message,
    this.user,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);
}

@JsonSerializable()
class User {
  final ProfilePic? profilePic;
  final CoverPic? coverPic;

  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final String? email;
  final String? provider;
  final String? gender;

  @JsonKey(name: 'DOB')
  final String? dob;

  final String? mobileNumber;
  final String? role;
  final bool? isTranslator;
  final bool? isVerified;
  final bool? isDeleted;
  final String? mediaCloudFolder;
  final List<dynamic>? companyOwnered;
  final String? createdAt;
  final String? updatedAt;
  final int? age;
  @JsonKey(name: 'Translator')
  final List<dynamic>? translator;

  @JsonKey(name: 'id')
  final String? userId;

  User({
    this.profilePic,
    this.coverPic,
    this.id,
    this.name,
    this.email,
    this.provider,
    this.gender,
    this.dob,
    this.mobileNumber,
    this.role,
    this.isTranslator,
    this.isVerified,
    this.isDeleted,
    this.mediaCloudFolder,
    this.companyOwnered,
    this.createdAt,
    this.updatedAt,
    this.age,
    this.translator,
    this.userId,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class ProfilePic {
  @JsonKey(name: 'public_id')
  final String? publicId;

  @JsonKey(name: 'secure_url')
  final String? secureUrl;

  ProfilePic({
    this.publicId,
    this.secureUrl,
  });

  factory ProfilePic.fromJson(Map<String, dynamic> json) =>
      _$ProfilePicFromJson(json);
  Map<String, dynamic> toJson() => _$ProfilePicToJson(this);
}

@JsonSerializable()
class CoverPic {
  @JsonKey(name: 'public_id')
  final String? publicId;

  @JsonKey(name: 'secure_url')
  final String? secureUrl;

  CoverPic({
    this.publicId,
    this.secureUrl,
  });

  factory CoverPic.fromJson(Map<String, dynamic> json) =>
      _$CoverPicFromJson(json);
  Map<String, dynamic> toJson() => _$CoverPicToJson(this);
}
