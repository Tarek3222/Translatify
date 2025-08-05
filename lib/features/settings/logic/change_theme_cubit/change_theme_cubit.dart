import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/di/depandecy_injection.dart';
import 'package:translators/core/helpers/shared_preference_helper.dart';
import 'package:translators/core/theme/app_theme.dart';
import 'package:translators/features/settings/logic/change_theme_cubit/change_theme_state.dart';

class ChangeThemeCubit extends Cubit<ThemeState> {
  ChangeThemeCubit() : super(_initialState);

  static final ThemeState _initialState = ThemeState(
    themeData: ThemeManager.lightTheme,
    appTheme: AppTheme.light,
    themeMode: ThemeMode.light,
  );

  Future<void> loadTheme() async {
    try {
      // Initialize ThemeManager if not already done
      if (!ThemeManager.isInitialized) {
        ThemeManager.initialize();
      }

      final themeString =
          getIt<SharedPrefHelper>().getString('app_theme') ?? 'light';
      final themeModeString =
          getIt<SharedPrefHelper>().getString('theme_mode') ?? 'light';

      // Map string to AppTheme enum
      final appTheme = themeString == 'dark' ? AppTheme.dark : AppTheme.light;

      // Map string to ThemeMode
      final themeMode = _stringToThemeMode(themeModeString);

      // Apply theme mode to ThemeManager
      ThemeManager.setThemeMode(themeMode);

      _applyTheme(appTheme, themeMode);
    } catch (e) {
      // Fallback to light theme if there's an error
      _applyTheme(AppTheme.light, ThemeMode.light);
    }
  }

  void toggleTheme() async {
    try {
      final newTheme =
          state.appTheme == AppTheme.light ? AppTheme.dark : AppTheme.light;
      final newThemeMode =
          newTheme == AppTheme.light ? ThemeMode.light : ThemeMode.dark;

      // Update ThemeManager
      ThemeManager.setThemeMode(newThemeMode);

      _applyTheme(newTheme, newThemeMode);

      // Save both theme and theme mode
      await getIt<SharedPrefHelper>().setData('app_theme', newTheme.name);
      await getIt<SharedPrefHelper>().setData('theme_mode', newThemeMode.name);
    } catch (e) {
      // Handle error silently or log it
      debugPrint('Error toggling theme: $e');
    }
  }

  void setThemeMode(ThemeMode themeMode) async {
    try {
      final appTheme =
          themeMode == ThemeMode.dark ? AppTheme.dark : AppTheme.light;

      // Update ThemeManager
      ThemeManager.setThemeMode(themeMode);

      _applyTheme(appTheme, themeMode);

      // Save theme mode
      await getIt<SharedPrefHelper>().setData('theme_mode', themeMode.name);
      await getIt<SharedPrefHelper>().setData('app_theme', appTheme.name);
    } catch (e) {
      debugPrint('Error setting theme mode: $e');
    }
  }

  void setSystemTheme() async {
    try {
      // Update ThemeManager to use system theme
      ThemeManager.setThemeMode(ThemeMode.system);

      // Determine current system theme
      final isDark = ThemeManager.isDarkMode;
      final appTheme = isDark ? AppTheme.dark : AppTheme.light;

      _applyTheme(appTheme, ThemeMode.system);

      // Save theme mode
      await getIt<SharedPrefHelper>().setData('theme_mode', 'system');
      await getIt<SharedPrefHelper>().setData('app_theme', appTheme.name);
    } catch (e) {
      debugPrint('Error setting system theme: $e');
    }
  }

  void _applyTheme(AppTheme theme, ThemeMode themeMode) {
    final themeData = ThemeManager.getCurrentTheme();
    emit(ThemeState(
      themeData: themeData,
      appTheme: theme,
      themeMode: themeMode,
    ));
  }

  ThemeMode _stringToThemeMode(String themeModeString) {
    switch (themeModeString.toLowerCase()) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.light;
    }
  }

  /// Get current theme mode
  ThemeMode get currentThemeMode => state.themeMode;

  /// Check if current theme is dark
  bool get isDarkMode => ThemeManager.isDarkMode;

  /// Get current theme data
  ThemeData get currentTheme => state.themeData;

  /// Clear theme cache (useful for testing or memory management)
  void clearThemeCache() {
    ThemeManager.clearCache();
  }
}
