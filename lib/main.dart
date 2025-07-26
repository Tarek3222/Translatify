import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:translators/core/di/depandecy_injection.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/helpers/shared_preference_helper.dart';
import 'package:translators/core/routing/app_router.dart';
import 'package:translators/core/utils/api_keys.dart';
import 'package:translators/core/utils/app_constants.dart';
import 'package:translators/core/utils/user_model.dart';
import 'package:translators/features/settings/logic/change_theme_cubit/change_theme_cubit.dart';
import 'package:translators/translators_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    ScreenUtil.ensureScreenSize(),
    EasyLocalization.ensureInitialized(),
    setupDependencyInjection(),
    dotenv.load(fileName: ".env"),
  ]);
  await checkIfLoggedInUser();
  Stripe.publishableKey = APiKeys.publishableKey;
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
        Locale('fr'),
        Locale('es'),
        Locale('de'),
        Locale('zh'),
      ],
      path: 'assets/translations',
      child: BlocProvider(
        create: (context) => ChangeThemeCubit()..loadTheme(),
        child: TranslatorsApp(
          appRouter: AppRouter(),
        ),
      ),
    ),
  );
}

Future<void> checkIfLoggedInUser() async {
  String? userData = await getIt<SharedPrefHelper>()
      .getSecuredString(SharedPrefKeys.kUserDataKey);
  String? userToken;
  if (userData != null) {
    userToken = UserModel.fromJson(
      jsonDecode(userData),
    ).token.accessToken;
  }

  if (userToken.isNullOrEmpty()) {
    isLoggedIn = false;
  } else {
    isLoggedIn = true;
  }
}
