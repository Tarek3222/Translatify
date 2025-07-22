import 'package:dartz/dartz.dart';
import 'package:translator/core/networking/api_error_handler.dart';
import 'package:translator/core/networking/api_error_model.dart';
import 'package:translator/core/networking/api_service.dart';
import 'package:translator/features/settings/data/models/update_password_request_body.dart';

class UpdatePasswordRepo {
  final ApiService _apiService;

  UpdatePasswordRepo(this._apiService);

  Future<Either<ApiErrorModel, String>> updatePassword(
      UpdatePasswordRequestBody requestBody) async {
    try {
      final response = await _apiService.updatePassword(requestBody);
      return Right(response);
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }
}
