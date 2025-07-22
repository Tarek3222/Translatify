import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:translator/core/networking/api_constants.dart';
import 'package:translator/core/networking/api_error_handler.dart';
import 'package:translator/core/networking/api_error_model.dart';
import 'package:translator/features/user_profile/data/data_source/remote_data_source/upload_image_data_source.dart';

class UploadUserImagesRepo {
  final UploadImageDataSource _uploadImageDataSource;
  UploadUserImagesRepo(this._uploadImageDataSource);

  Future<Either<ApiErrorModel, String>> uploadUserProfileImage(
      {required File file}) async {
    try {
      String response = await _uploadImageDataSource.uploadImage(
          file: file,
          endpoint: ApiConstants.updateUserProfileImageEndpoint,
          key: "profile");
      return Right(response);
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, String>> uploadUserCoverImage(
      {required File file}) async {
    try {
      String response = await _uploadImageDataSource.uploadImage(
          file: file,
          endpoint: ApiConstants.updateUserCoverImageEndpoint,
          key: "cover");
      return Right(response);
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }
}
