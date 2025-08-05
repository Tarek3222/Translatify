import 'package:flutter/material.dart';

enum AppTheme { light, dark }

class ThemeState {
  final ThemeData themeData;
  final AppTheme appTheme;
  final ThemeMode themeMode;

  const ThemeState({
    required this.themeData,
    required this.appTheme,
    required this.themeMode,
  });

  /// Create a copy of this state with updated values
  ThemeState copyWith({
    ThemeData? themeData,
    AppTheme? appTheme,
    ThemeMode? themeMode,
  }) {
    return ThemeState(
      themeData: themeData ?? this.themeData,
      appTheme: appTheme ?? this.appTheme,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  /// Check if current theme is dark
  bool get isDarkMode => appTheme == AppTheme.dark;

  /// Get theme mode as string
  String get themeModeString => themeMode.name;

  /// Get app theme as string
  String get appThemeString => appTheme.name;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ThemeState &&
        other.themeData == themeData &&
        other.appTheme == appTheme &&
        other.themeMode == themeMode;
  }

  @override
  int get hashCode {
    return themeData.hashCode ^ appTheme.hashCode ^ themeMode.hashCode;
  }

  @override
  String toString() {
    return 'ThemeState(themeData: $themeData, appTheme: $appTheme, themeMode: $themeMode)';
  }
}
