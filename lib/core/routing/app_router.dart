import 'package:flutter/material.dart';
import 'package:translator/core/routing/routes.dart';
import 'package:translator/features/on_boarding/ui/views/on_boarding_view.dart';
import 'package:translator/features/sign_in/ui/views/sign_in_view.dart';
import 'package:translator/features/sign_up/ui/views/sign_up_view.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (context) => const OnBoardingView(),
        );
      case Routes.signInScreen:
        return MaterialPageRoute(
          builder: (context) => const SignInView(),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (context) => const SignUpView(),
        );
      default:
        return null;
    }
  }
}
