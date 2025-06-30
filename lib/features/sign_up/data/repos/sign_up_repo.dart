import 'package:translator/core/networking/api_error_handler.dart';
import 'package:translator/core/networking/api_error_model.dart';
import 'package:translator/core/networking/api_service.dart';
import 'package:translator/features/sign_up/data/models/confirm_email_request_body.dart';
import 'package:translator/features/sign_up/data/models/sign_up_request_body.dart';
import 'package:dartz/dartz.dart';

class SignUpRepo {
  final ApiService apiService;

  SignUpRepo(this.apiService);

  Future<Either<ApiErrorModel, String>> sigUpUser(
      SignUpRequestBody signUpRequestBody) async {
    try {
      String response = await apiService.signUp(signUpRequestBody);
      return Right(response);
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, String>> confirmEmail(
      ConfirmEmailRequestBody confirmEmailRequestBody) async {
    try {
      String response = await apiService.confirmEmail(confirmEmailRequestBody);
      return Right(response);
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }
}
