// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/features/settings/logic/change_theme_cubit/change_theme_cubit.dart';
import 'package:translators/features/settings/logic/change_theme_cubit/change_theme_state.dart';

class ThemeSwitchWidget extends StatelessWidget {
  const ThemeSwitchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeThemeCubit, ThemeState>(
      builder: (context, state) {
        final isDark = state.isDarkMode;

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
      },
    );
  }
}

/// Enhanced theme selector widget with multiple theme mode options
class ThemeModeSelectorWidget extends StatelessWidget {
  const ThemeModeSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeThemeCubit, ThemeState>(
      builder: (context, state) {
        return PopupMenuButton<ThemeMode>(
          icon: Icon(
            state.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onSelected: (ThemeMode themeMode) {
            final cubit = context.read<ChangeThemeCubit>();
            switch (themeMode) {
              case ThemeMode.light:
                cubit.setThemeMode(ThemeMode.light);
                break;
              case ThemeMode.dark:
                cubit.setThemeMode(ThemeMode.dark);
                break;
              case ThemeMode.system:
                cubit.setSystemTheme();
                break;
            }
          },
          itemBuilder: (BuildContext context) => [
            PopupMenuItem<ThemeMode>(
              value: ThemeMode.light,
              child: Row(
                children: [
                  Icon(
                    Icons.light_mode,
                    color: state.themeMode == ThemeMode.light
                        ? AppColors.mainBlue
                        : null,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Light',
                    style: TextStyle(
                      color: state.themeMode == ThemeMode.light
                          ? AppColors.mainBlue
                          : null,
                      fontWeight: state.themeMode == ThemeMode.light
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem<ThemeMode>(
              value: ThemeMode.dark,
              child: Row(
                children: [
                  Icon(
                    Icons.dark_mode,
                    color: state.themeMode == ThemeMode.dark
                        ? AppColors.mainBlue
                        : null,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Dark',
                    style: TextStyle(
                      color: state.themeMode == ThemeMode.dark
                          ? AppColors.mainBlue
                          : null,
                      fontWeight: state.themeMode == ThemeMode.dark
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem<ThemeMode>(
              value: ThemeMode.system,
              child: Row(
                children: [
                  Icon(
                    Icons.settings_system_daydream,
                    color: state.themeMode == ThemeMode.system
                        ? AppColors.mainBlue
                        : null,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'System',
                    style: TextStyle(
                      color: state.themeMode == ThemeMode.system
                          ? AppColors.mainBlue
                          : null,
                      fontWeight: state.themeMode == ThemeMode.system
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
