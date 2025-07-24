// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:translators/core/theme/app_colors.dart';

/// ThemeManager is an abstract class that provides light and dark themes
abstract class ThemeManager {
  //! Light Theme
  static ThemeData lightTheme = ThemeData.light(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: AppColors.white,
    colorScheme: const ColorScheme.light(
      primary: AppColors.mainBlue,
      secondary: AppColors.darkBlue,
      onPrimary: AppColors.mainBlue,
      onSecondary: AppColors.mainDarkBlue,
      surface: AppColors.mainBlue,
      onSurface: AppColors.lightBlue,
      surfaceContainer: AppColors.white,
      background: AppColors.lighterLighterGrey,
      onBackground: AppColors.grey,
      error: AppColors.mainRed,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
      },
    ),
  );
  //! Dark Theme
  static ThemeData darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: AppColors.mainDarkBlue,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.mainBlue,
      secondary: AppColors.white,
      onPrimary: AppColors.white,
      onSecondary: AppColors.mainBlue,
      surface: AppColors.mainDarkBlue,
      onSurface: AppColors.lightBlue,
      surfaceContainer: AppColors.mainDarkBlue,
      background: AppColors.mainDarkBlue,
      onBackground: AppColors.white,
      error: AppColors.mainRed,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
      },
    ),
  );
}
