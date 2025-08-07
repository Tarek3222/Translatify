import 'package:json_annotation/json_annotation.dart';
part 'review_request_body.g.dart';

@JsonSerializable()
class ReviewRequestBody {
  final num rating;
  final String comment;

  ReviewRequestBody({
    required this.rating,
    required this.comment,
  });

  factory ReviewRequestBody.fromJson(Map<String, dynamic> json) =>
      _$ReviewRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewRequestBodyToJson(this);
}
