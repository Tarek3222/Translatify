import 'dart:convert';

import 'package:translator/core/di/depandecy_injection.dart';
import 'package:translator/core/helpers/shared_preference_helper.dart';
import 'package:translator/core/utils/app_constants.dart';
import 'package:translator/features/user_profile/data/models/user_profile_model.dart';

String getEmailCurruntUser() {
  final String jsonString = getIt<SharedPrefHelper>().getString(
    SharedPrefKeys.kUserProfileKey,
  )!;
  return UserProfileModel.fromJson(
    json.decode(jsonString),
  ).user!.email!;
}
