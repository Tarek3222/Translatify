import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:translator/core/networking/api_constants.dart';
import 'package:translator/features/sign_in/data/models/reset_password_request_body.dart';
import 'package:translator/features/sign_in/data/models/sign_in_request_body.dart';
import 'package:translator/features/sign_up/data/models/confirm_email_request_body.dart';
import 'package:translator/features/sign_up/data/models/sign_up_request_body.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) = _ApiService;

  @POST(ApiConstants.signUp)
  Future<String> signUp(@Body() SignUpRequestBody signUpRequestBody);

  @POST(ApiConstants.signInEndpoint)
  Future<String> signIn(@Body() SignInRequestBody signInRequestBody);

  @PUT(ApiConstants.confirmEmail)
  Future<String> confirmEmail(
      @Body() ConfirmEmailRequestBody confirmEmailRequestBody);

  @POST(ApiConstants.forgetPasswordEndpoint)
  Future<String> forgetPassword(
      @Path("email") String email, @Body() Map<String, dynamic> emailBody);

  @POST(ApiConstants.resetPasswordEndpoint)
  Future<String> resetPassword(@Path("email") String email,
      @Body() ResetPasswordRequestBody resetPasswordRequestBody);
}
