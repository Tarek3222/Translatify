// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:translator/core/theme/app_colors.dart';

abstract class ThemeManager {
  static ThemeData lightTheme = ThemeData.light(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: AppColors.white,
    colorScheme: const ColorScheme.light(
      primary: AppColors.mainBlue,
      secondary: AppColors.lightBlue,
      onPrimary: AppColors.mainBlue,
      onSecondary: AppColors.mainDarkBlue,
      surface: AppColors.mainBlue,
      onSurface: AppColors.black,
      surfaceContainer: AppColors.white,
      background: AppColors.lighterLighterGrey,
    ),
  );
  static ThemeData darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: AppColors.black,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.mainBlue,
      secondary: AppColors.lightBlue,
      onPrimary: AppColors.white,
      onSecondary: AppColors.mainBlue,
      surface: AppColors.darkBlue,
      onSurface: AppColors.white,
      surfaceContainer: AppColors.black,
      background: AppColors.black,
    ),
  );
}
