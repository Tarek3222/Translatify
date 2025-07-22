import 'package:json_annotation/json_annotation.dart';

part 'translator_response_model.g.dart';

@JsonSerializable()
class TranslatorResponseModel {
  final String? message;
  final List<TranslatorProfileModel>? translators;

  TranslatorResponseModel({
    this.message,
    this.translators,
  });

  factory TranslatorResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TranslatorResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$TranslatorResponseModelToJson(this);
}

@JsonSerializable()
class TranslatorProfileModel {
  final ProfilePic? profilePic;
  final CoverPic? coverPic;

  @JsonKey(name: '_id')
  final String? id;

  final String? name;
  final String? gender;

  @JsonKey(name: 'DOB')
  final String? dob;

  final String? mobileNumber;
  final num? age;

  @JsonKey(name: 'Translator')
  final List<Translator>? translator;

  @JsonKey(name: 'id')
  final String? userId;

  TranslatorProfileModel({
    this.profilePic,
    this.coverPic,
    this.id,
    this.name,
    this.gender,
    this.dob,
    this.mobileNumber,
    this.age,
    this.translator,
    this.userId,
  });

  factory TranslatorProfileModel.fromJson(Map<String, dynamic> json) =>
      _$TranslatorProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$TranslatorProfileModelToJson(this);
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

@JsonSerializable()
class Translator {
  final Cv? cv;

  @JsonKey(name: '_id')
  final String? id;

  final String? userId;
  final List<String>? language;
  final int? experienceYears;
  final String? bio;
  final String? location;
  final bool? availability;
  final List<String>? type;
  final num? averageRating;
  final int? numberOfRating;
  final List<Certification>? certifications;

  Translator({
    this.cv,
    this.id,
    this.userId,
    this.language,
    this.experienceYears,
    this.bio,
    this.location,
    this.availability,
    this.type,
    this.averageRating,
    this.numberOfRating,
    this.certifications,
  });

  factory Translator.fromJson(Map<String, dynamic> json) =>
      _$TranslatorFromJson(json);

  Map<String, dynamic> toJson() => _$TranslatorToJson(this);
}

@JsonSerializable()
class Cv {
  @JsonKey(name: 'public_id')
  final String? publicId;

  @JsonKey(name: 'secure_url')
  final String? secureUrl;

  Cv({
    this.publicId,
    this.secureUrl,
  });

  factory Cv.fromJson(Map<String, dynamic> json) => _$CvFromJson(json);

  Map<String, dynamic> toJson() => _$CvToJson(this);
}

@JsonSerializable()
class Certification {
  @JsonKey(name: 'public_id')
  final String? publicId;

  @JsonKey(name: 'secure_url')
  final String? secureUrl;

  @JsonKey(name: '_id')
  final String? id;

  Certification({
    this.publicId,
    this.secureUrl,
    this.id,
  });

  factory Certification.fromJson(Map<String, dynamic> json) =>
      _$CertificationFromJson(json);

  Map<String, dynamic> toJson() => _$CertificationToJson(this);
}
