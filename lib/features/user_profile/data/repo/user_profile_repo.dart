import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:translator/core/networking/api_error_handler.dart';
import 'package:translator/core/networking/api_error_model.dart';
import 'package:translator/core/networking/api_service.dart';
import 'package:translator/core/networking/network_info.dart';
import 'package:translator/features/user_profile/data/data_source/local_data_source/user_profile_local_data_source.dart';
import 'package:translator/features/user_profile/data/models/user_profile_model.dart';

class UserProfileRepo {
  final ApiService _apiService;
  final NetworkInfo _networkInfo;
  final UserProfileLocalDataSource _userProfileLocalDataSource;

  UserProfileRepo(
      this._apiService, this._networkInfo, this._userProfileLocalDataSource);

  Future<Either<ApiErrorModel, UserProfileModel>> getUserProfile() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _apiService.getUserProfile();
        await _userProfileLocalDataSource.cacheUserProfile(
            userProfileToCache: response);
        return Right(UserProfileModel.fromJson(jsonDecode(response)));
      } catch (e) {
        return Left(ApiErrorHandler.handle(e));
      }
    } else {
      try {
        final localData =
            await _userProfileLocalDataSource.getLastUserProfile();
        return Right(localData);
      } catch (e) {
        return Left(
          ApiErrorModel(message: e.toString()),
        );
      }
    }
  }
}
