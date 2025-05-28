import 'package:flutter/material.dart';
import 'package:translator/core/routing/routes.dart';
import 'package:translator/features/on_boarding/ui/views/on_boarding_view.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (context) => const OnBoardingView(),
        );
      default:
        return null;
    }
  }
}
