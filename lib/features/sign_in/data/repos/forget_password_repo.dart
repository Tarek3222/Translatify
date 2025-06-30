import 'package:dartz/dartz.dart';
import 'package:translator/core/networking/api_error_handler.dart';
import 'package:translator/core/networking/api_error_model.dart';
import 'package:translator/core/networking/api_service.dart';

class ForgetPasswordRepo {
  final ApiService apiService;
  ForgetPasswordRepo(this.apiService);

  Future<Either<ApiErrorModel, String>> forgetPassword(String email) async {
    try {
      final response = await apiService.forgetPassword(email, {'email': email});
      return Right(response);
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }
}
