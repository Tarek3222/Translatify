import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/core/di/depandecy_injection.dart';
import 'package:translator/core/routing/routes.dart';
import 'package:translator/features/main/logic/bottom_nav_bar_cubit/bottom_nav_bar_index_cubit.dart';
import 'package:translator/features/main/ui/main_view.dart';
import 'package:translator/features/on_boarding/ui/views/on_boarding_view.dart';
import 'package:translator/features/sign_in/data/repos/reset_password_repo.dart';
import 'package:translator/features/sign_in/data/repos/sign_in_repo.dart';
import 'package:translator/features/sign_in/logic/forget_password_cubit/forget_password_cubit.dart';
import 'package:translator/features/sign_in/logic/reset_password_cubit/reset_password_cubit.dart';
import 'package:translator/features/sign_in/logic/sign_in_cubit/sign_in_cubit.dart';
import 'package:translator/features/sign_in/ui/views/forget_password_view.dart';
import 'package:translator/features/sign_in/ui/views/reset_password_view.dart';
import 'package:translator/features/sign_in/ui/views/sign_in_view.dart';
import 'package:translator/features/sign_up/data/repos/sign_up_repo.dart';
import 'package:translator/features/sign_up/logic/confirm_email_cubit/confirm_email_cubit.dart';
import 'package:translator/features/sign_up/logic/sign_up_cubit/sign_up_cubit.dart';
import 'package:translator/features/sign_up/ui/views/sign_up_view.dart';
import 'package:translator/features/sign_up/ui/views/verification_code_email_view.dart';
import 'package:translator/features/translator_profile/ui/translator_profile_view.dart';

import '../../features/sign_in/data/repos/forget_password_repo.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (context) => const OnBoardingView(),
        );
      case Routes.mainScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => BottomNavBarIndexCubit(),
            child: const MainView(),
          ),
        );
      case Routes.translatorProfileScreen:
        return MaterialPageRoute(
          builder: (context) => const TranslatorProfileView(),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => SignupCubit(getIt<SignUpRepo>()),
            child: const SignUpView(),
          ),
        );
      case Routes.signInScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
              create: (context) => SignInCubit(getIt<SignInRepo>()),
              child: const SignInView()),
        );
      case Routes.forgetPassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
              create: (context) =>
                  ForgetPasswordCubit(getIt<ForgetPasswordRepo>()),
              child: const ForgetPasswordView()),
        );
      case Routes.verifyCodeEmail:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ConfirmEmailCubit(getIt<SignUpRepo>()),
            child: VerificationEmailCodeView(
              email: settings.arguments as String? ?? '',
            ),
          ),
        );
      case Routes.resetPassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ResetPasswordCubit(getIt<ResetPasswordRepo>()),
            child: ResetPasswordView(
              email: settings.arguments as String? ?? '',
            ),
          ),
        );
      default:
        return null;
    }
  }
}
