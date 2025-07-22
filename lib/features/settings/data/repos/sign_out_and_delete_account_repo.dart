import 'package:dartz/dartz.dart';
import 'package:translator/core/networking/api_error_handler.dart';
import 'package:translator/core/networking/api_error_model.dart';
import 'package:translator/core/networking/api_service.dart';

class SignOutAndDeleteAccountRepo {
  final ApiService _apiService;

  SignOutAndDeleteAccountRepo(this._apiService);

  Future<Either<ApiErrorModel, String>> signOut() async {
    try {
      final response = await _apiService.signOut();
      return Right(response);
    } catch (error) {
      return Left(ApiErrorHandler.handle(error));
    }
  }

  Future<Either<ApiErrorModel, String>> deleteAccount() async {
    try {
      final response = await _apiService.deleteAccount();
      return Right(response);
    } catch (error) {
      return Left(ApiErrorHandler.handle(error));
    }
  }
}
