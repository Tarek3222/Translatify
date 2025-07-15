// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/features/settings/logic/cubit/change_theme_cubit.dart';
import 'package:translator/features/settings/logic/cubit/change_theme_state.dart';

class ThemeSwitchWidget extends StatelessWidget {
  const ThemeSwitchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark =
        context.watch<ChangeThemeCubit>().state.appTheme == AppTheme.dark;
    return Switch(
      activeColor: AppColors.mainBlue,
      inactiveThumbColor: AppColors.grey,
      inactiveTrackColor: AppColors.grey.withOpacity(0.5),
      activeTrackColor: AppColors.mainBlue.withOpacity(0.5),
      value: isDark,
      onChanged: (value) {
        context.read<ChangeThemeCubit>().toggleTheme();
      },
    );
  }
}
