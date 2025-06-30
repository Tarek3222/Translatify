import 'package:json_annotation/json_annotation.dart';
part 'confirm_email_request_body.g.dart';

@JsonSerializable()
class ConfirmEmailRequestBody {
  final String email;
  final String code;

  ConfirmEmailRequestBody({
    required this.email,
    required this.code,
  });

  factory ConfirmEmailRequestBody.fromJson(Map<String, dynamic> json) =>
      _$ConfirmEmailRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmEmailRequestBodyToJson(this);
}
