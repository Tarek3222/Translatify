import 'package:json_annotation/json_annotation.dart';
part 'sign_in_request_body.g.dart';

@JsonSerializable()
class SignInRequestBody {
  final String password;
  final String email;

  SignInRequestBody({
    required this.password,
    required this.email,
  });

  factory SignInRequestBody.fromJson(Map<String, dynamic> json) =>
      _$SignInRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SignInRequestBodyToJson(this);
}
