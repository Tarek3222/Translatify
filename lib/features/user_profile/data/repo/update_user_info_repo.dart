import 'package:dartz/dartz.dart';
import 'package:translator/core/networking/api_error_handler.dart';
import 'package:translator/core/networking/api_error_model.dart';
import 'package:translator/core/networking/api_service.dart';
import 'package:translator/features/user_profile/data/models/update_user_request_body.dart';

class UpdateUserInfoRepo {
  final ApiService _apiService;

  UpdateUserInfoRepo(this._apiService);

  Future<Either<ApiErrorModel, String>> updateUserInfo(
      UpdateUserRequestBody updateUserRequestBody) async {
    try {
      String response = await _apiService.updateUser(updateUserRequestBody);
      return Right(response);
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }
}
