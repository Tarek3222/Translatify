import 'package:json_annotation/json_annotation.dart';
part 'update_password_request_body.g.dart';

@JsonSerializable()
class UpdatePasswordRequestBody {
  final String currentPassword;
  final String newPassword;
  final String confirmNewPassword;

  const UpdatePasswordRequestBody({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmNewPassword,
  });

  factory UpdatePasswordRequestBody.fromJson(Map<String, dynamic> json) =>
      _$UpdatePasswordRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePasswordRequestBodyToJson(this);
}
