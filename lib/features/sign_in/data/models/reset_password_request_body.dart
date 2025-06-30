import 'package:json_annotation/json_annotation.dart';
part 'reset_password_request_body.g.dart';

@JsonSerializable()
class ResetPasswordRequestBody {
  final String password;
  final String confirmOtp;
  final String confirmPassword;

  ResetPasswordRequestBody({
    required this.password,
    required this.confirmOtp,
    required this.confirmPassword,
  });

  factory ResetPasswordRequestBody.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordRequestBodyToJson(this);
}
