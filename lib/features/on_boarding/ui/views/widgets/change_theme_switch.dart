// ignore_for_file: deprecated_member_use

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/features/on_boarding/ui/views/widgets/theme_switch_widget.dart';

class ChangeThemeSwitch extends StatelessWidget {
  const ChangeThemeSwitch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
          const ThemeSwitchWidget(),
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
