import 'package:dartz/dartz.dart';
import 'package:translator/core/networking/api_error_handler.dart';
import 'package:translator/core/networking/api_error_model.dart';
import 'package:translator/core/networking/api_service.dart';
import 'package:translator/features/sign_in/data/models/reset_password_request_body.dart';

class ResetPasswordRepo {
  final ApiService apiService;
  ResetPasswordRepo(this.apiService);

  Future<Either<ApiErrorModel, String>> resetPassword(
      String email, ResetPasswordRequestBody resetPasswordRequestBody) async {
    try {
      final response = await apiService.resetPassword(
        email,
        resetPasswordRequestBody,
      );
      return Right(response);
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }
}
