import 'package:flutter/material.dart';

enum AppTheme { light, dark }

class ThemeState {
  final ThemeData themeData;
  final AppTheme appTheme;

  ThemeState({required this.themeData, required this.appTheme});
}
