import 'package:json_annotation/json_annotation.dart';
part 'sign_up_request_body.g.dart';

@JsonSerializable()
class SignUpRequestBody {
  final String email;
  final String name;
  final String password;
  final String confirmPassword;
  final String mobileNumber;
  @JsonKey(name: 'DOB')
  final String dateOfBirth;
  final String gender;

  SignUpRequestBody({
    required this.email,
    required this.name,
    required this.password,
    required this.confirmPassword,
    required this.mobileNumber,
    required this.dateOfBirth,
    required this.gender,
  });

  factory SignUpRequestBody.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpRequestBodyToJson(this);
}
