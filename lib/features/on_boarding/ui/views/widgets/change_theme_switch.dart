// ignore_for_file: deprecated_member_use

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/features/settings/logic/cubit/change_theme_cubit.dart';
import 'package:translator/features/settings/logic/cubit/change_theme_state.dart';

class ChangeThemeSwitch extends StatelessWidget {
  const ChangeThemeSwitch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark =
        context.watch<ChangeThemeCubit>().state.appTheme == AppTheme.dark;
    return ElasticIn(
      delay: const Duration(milliseconds: 200),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            Icons.light_mode,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 30.w,
          ),
          Switch(
            activeColor: AppColors.mainBlue,
            inactiveThumbColor: AppColors.grey,
            inactiveTrackColor: AppColors.grey.withOpacity(0.5),
            activeTrackColor: AppColors.mainBlue.withOpacity(0.5),
            value: isDark,
            onChanged: (value) {
              context.read<ChangeThemeCubit>().toggleTheme();
            },
          ),
          Icon(
            Icons.dark_mode,
            color: Theme.of(context).colorScheme.onSecondary,
            size: 30.w,
          ),
        ],
      ),
    );
  }
}
