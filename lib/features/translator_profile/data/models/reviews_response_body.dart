import 'package:json_annotation/json_annotation.dart';
part 'reviews_response_body.g.dart';

@JsonSerializable()
class ReviewsResponseBody {
  final String? message;
  final int? reviewsCount;

  final List<ReviewModel>? reviews;

  ReviewsResponseBody({this.message, this.reviewsCount, this.reviews});
  factory ReviewsResponseBody.fromJson(Map<String, dynamic> json) =>
      _$ReviewsResponseBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewsResponseBodyToJson(this);
}

@JsonSerializable()
class ReviewModel {
  @JsonKey(name: "_id")
  final String? id;
  final ReviewerId? reviewerId;
  final String? reviewedUserId;
  final num? rating;
  final String? comment;
  final String? createdAt;
  final String? updatedAt;
  @JsonKey(name: "__v")
  final int? v;

  ReviewModel({
    this.id,
    this.reviewerId,
    this.reviewedUserId,
    this.rating,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}

@JsonSerializable()
class ReviewerId {
  @JsonKey(name: "_id")
  final String? id;
  final String? name;
  final String? email;
  final num? age;

  ReviewerId({this.id, this.name, this.email, this.age});

  factory ReviewerId.fromJson(Map<String, dynamic> json) =>
      _$ReviewerIdFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewerIdToJson(this);
}
