import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/di/depandecy_injection.dart';
import 'package:translators/core/helpers/shared_preference_helper.dart';
import 'package:translators/core/theme/app_theme.dart';
import 'package:translators/features/settings/logic/change_theme_cubit/change_theme_state.dart';

class ChangeThemeCubit extends Cubit<ThemeState> {
  ChangeThemeCubit() : super(_initialState);

  static final ThemeState _initialState = ThemeState(
    themeData: ThemeData.light(),
    appTheme: AppTheme.light,
  );

  Future<void> loadTheme() async {
    final themeString =
        getIt<SharedPrefHelper>().getString('app_theme') ?? 'light';
    final appTheme = themeString == 'dark' ? AppTheme.dark : AppTheme.light;
    _applyTheme(appTheme);
  }

  void toggleTheme() async {
    final newTheme =
        state.appTheme == AppTheme.light ? AppTheme.dark : AppTheme.light;
    _applyTheme(newTheme);

    await getIt<SharedPrefHelper>().setData('app_theme', newTheme.name);
  }

  void _applyTheme(AppTheme theme) {
    final themeData = theme == AppTheme.dark
        ? ThemeManager.darkTheme
        : ThemeManager.lightTheme;
    emit(ThemeState(themeData: themeData, appTheme: theme));
  }
}
