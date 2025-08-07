import 'package:dartz/dartz.dart';
import 'package:translators/core/networking/api_error_handler.dart';
import 'package:translators/core/networking/api_error_model.dart';
import 'package:translators/core/networking/api_service.dart';

class DeleteUserImagesRepo {
  final ApiService _apiService;

  DeleteUserImagesRepo(this._apiService);

  Future<Either<ApiErrorModel, String>> deleteUserProfileImage() async {
    try {
      String response = await _apiService.deleteUserProfileImage();
      return Right(response);
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, String>> deleteUserCoverImage() async {
    try {
      String response = await _apiService.deleteUserCoverImage();
      return Right(response);
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }
}
