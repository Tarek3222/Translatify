import 'dart:convert';

import 'package:translators/core/di/depandecy_injection.dart';
import 'package:translators/core/helpers/shared_preference_helper.dart';
import 'package:translators/core/utils/app_constants.dart';
import 'package:translators/features/user_profile/data/models/user_profile_model.dart';

String getEmailCurruntUser() {
  final String jsonString = getIt<SharedPrefHelper>().getString(
    SharedPrefKeys.kUserProfileKey,
  )!;
  return UserProfileModel.fromJson(
    json.decode(jsonString),
  ).user!.email!;
}

String getIdCurruntUser() {
  final String jsonString = getIt<SharedPrefHelper>().getString(
    SharedPrefKeys.kUserProfileKey,
  )!;
  return UserProfileModel.fromJson(
    json.decode(jsonString),
  ).user!.id!;
}
