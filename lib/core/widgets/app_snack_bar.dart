import 'package:flutter/material.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/theme/app_styles.dart';

void showSnackBar({
  required BuildContext context,
  required String message,
  Color? backgroundColor,
  TextStyle? style,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: style ??
            getRegularStyle(
              fontSize: 14,
              color: AppColors.white,
            ),
      ),
      backgroundColor: backgroundColor ?? AppColors.mainRed,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
    ),
  );
}
