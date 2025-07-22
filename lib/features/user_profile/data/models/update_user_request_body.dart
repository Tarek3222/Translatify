import 'package:json_annotation/json_annotation.dart';

part 'update_user_request_body.g.dart';

@JsonSerializable()
class UpdateUserRequestBody {
  final String name;
  final String mobileNumber;
  @JsonKey(name: "DOB")
  final String dob;
  final String gender;

  UpdateUserRequestBody(this.name, this.mobileNumber, this.dob, this.gender);

  factory UpdateUserRequestBody.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserRequestBodyToJson(this);
}
