// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:translators/core/theme/app_colors.dart';

/// ThemeManager provides optimized theme management with caching and performance improvements
class ThemeManager {
  // Cache for theme instances to avoid repeated creation
  static ThemeData? _lightThemeCache;
  static ThemeData? _darkThemeCache;
  static bool _isInitialized = false;

  // Theme mode tracking
  static ThemeMode _currentThemeMode = ThemeMode.system;

  // Performance optimization: Pre-calculate common values
  static const _pageTransitionsTheme = PageTransitionsTheme(
    builders: {
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
    },
  );

  // Light theme color scheme
  static const _lightColorScheme = ColorScheme.light(
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
    brightness: Brightness.light,
  );

  // Dark theme color scheme
  static const _darkColorScheme = ColorScheme.dark(
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
    brightness: Brightness.dark,
  );

  /// Initialize themes (call this once at app startup)
  static void initialize() {
    if (_isInitialized) return;

    _lightThemeCache = _createLightTheme();
    _darkThemeCache = _createDarkTheme();
    _isInitialized = true;
  }

  /// Get light theme with caching
  static ThemeData get lightTheme {
    if (!_isInitialized) initialize();
    return _lightThemeCache!;
  }

  /// Get dark theme with caching
  static ThemeData get darkTheme {
    if (!_isInitialized) initialize();
    return _darkThemeCache!;
  }

  /// Get current theme mode
  static ThemeMode get currentThemeMode => _currentThemeMode;

  /// Set theme mode
  static void setThemeMode(ThemeMode mode) {
    _currentThemeMode = mode;
  }

  /// Toggle between light and dark themes
  static void toggleTheme() {
    switch (_currentThemeMode) {
      case ThemeMode.light:
        _currentThemeMode = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        _currentThemeMode = ThemeMode.light;
        break;
      case ThemeMode.system:
        _currentThemeMode = ThemeMode.light;
        break;
    }
  }

  /// Check if current theme is dark
  static bool get isDarkMode {
    switch (_currentThemeMode) {
      case ThemeMode.light:
        return false;
      case ThemeMode.dark:
        return true;
      case ThemeMode.system:
        // This would need to be determined by the system
        return false;
    }
  }

  /// Create optimized light theme
  static ThemeData _createLightTheme() {
    return ThemeData.light(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: AppColors.white,
        colorScheme: _lightColorScheme,
        pageTransitionsTheme: _pageTransitionsTheme,
        // Optimize card theme
        cardTheme: const CardTheme(
          color: AppColors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ));
  }

  /// Create optimized dark theme
  static ThemeData _createDarkTheme() {
    return ThemeData.dark(useMaterial3: true).copyWith(
      scaffoldBackgroundColor: AppColors.mainDarkBlue,
      colorScheme: _darkColorScheme,
      pageTransitionsTheme: _pageTransitionsTheme,
      // Optimize card theme for dark mode
      cardTheme: const CardTheme(
        color: AppColors.mainDarkBlue,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }

  /// Clear theme cache (useful for testing or memory management)
  static void clearCache() {
    _lightThemeCache = null;
    _darkThemeCache = null;
    _isInitialized = false;
  }

  /// Get theme based on current mode
  static ThemeData getCurrentTheme() {
    switch (_currentThemeMode) {
      case ThemeMode.light:
        return lightTheme;
      case ThemeMode.dark:
        return darkTheme;
      case ThemeMode.system:
        // Default to light theme for system mode
        return lightTheme;
    }
  }

  /// Check if theme is initialized
  static bool get isInitialized => _isInitialized;
}

// Backward compatibility
extension ThemeManagerExtension on ThemeManager {
  static ThemeData get lightTheme => ThemeManager.lightTheme;
  static ThemeData get darkTheme => ThemeManager.darkTheme;
}
