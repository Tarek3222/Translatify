// ignore_for_file: unnecessary_nullable_for_final_variable_declarations

import 'dart:convert';

import 'package:translators/core/di/depandecy_injection.dart';
import 'package:translators/core/helpers/shared_preference_helper.dart';
import 'package:translators/core/utils/app_constants.dart';
import 'package:translators/features/user_profile/data/models/user_profile_model.dart';

class UserProfileLocalDataSource {
  Future<void> cacheUserProfile({String? userProfileToCache}) async {
    if (userProfileToCache != null) {
      await getIt<SharedPrefHelper>().setData(
        SharedPrefKeys.kUserProfileKey,
        userProfileToCache,
      );
    } else {
      throw Exception('No Internet Connection');
    }
  }

  Future<UserProfileModel> getLastUserProfile() {
    final String? jsonString = getIt<SharedPrefHelper>().getString(
      SharedPrefKeys.kUserProfileKey,
    )!;

    if (jsonString != null) {
      return Future.value(
        UserProfileModel.fromJson(
          json.decode(jsonString),
        ),
      );
    } else {
      throw Exception('No Internet Connection');
    }
  }
}
