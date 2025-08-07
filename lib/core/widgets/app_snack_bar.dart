import 'package:flutter/material.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';

enum SnackBarType {
  success,
  error,
  warning,
  info,
}

class AppSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    SnackBarType type = SnackBarType.error,
    Color? backgroundColor,
    TextStyle? style,
    Duration? duration,
    SnackBarAction? action,
    bool showCloseIcon = true,
    EdgeInsetsGeometry? margin,
    double? elevation,
    ShapeBorder? shape,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
  }) {
    // Validate context to prevent errors
    if (!context.mounted) return;

    final effectiveDuration = duration ?? _getDefaultDuration(type);
    final effectiveBackgroundColor = backgroundColor ?? _getDefaultColor(type);
    final effectiveStyle = style ?? _getDefaultStyle(type);
    final effectiveMargin = margin ?? _getDefaultMargin(behavior);
    final effectiveElevation = elevation ?? _getDefaultElevation(type);
    final effectiveShape = shape ?? _getDefaultShape();

    final snackBar = SnackBar(
      content: _buildContent(message, effectiveStyle),
      backgroundColor: effectiveBackgroundColor,
      duration: effectiveDuration,
      behavior: behavior,
      showCloseIcon: showCloseIcon,
      action: action,
      margin: effectiveMargin,
      elevation: effectiveElevation,
      shape: effectiveShape,
      dismissDirection: DismissDirection.horizontal,
    );

    // Clear any existing snack bars before showing new one
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Convenience methods for different types
  static void showSuccess({
    required BuildContext context,
    required String message,
    Duration? duration,
    SnackBarAction? action,
  }) {
    show(
      context: context,
      message: message,
      type: SnackBarType.success,
      duration: duration,
      action: action,
    );
  }

  static void showError({
    required BuildContext context,
    required String message,
    Duration? duration,
    SnackBarAction? action,
  }) {
    show(
      context: context,
      message: message,
      type: SnackBarType.error,
      duration: duration,
      action: action,
    );
  }

  static void showWarning({
    required BuildContext context,
    required String message,
    Duration? duration,
    SnackBarAction? action,
  }) {
    show(
      context: context,
      message: message,
      type: SnackBarType.warning,
      duration: duration,
      action: action,
    );
  }

  static void showInfo({
    required BuildContext context,
    required String message,
    Duration? duration,
    SnackBarAction? action,
  }) {
    show(
      context: context,
      message: message,
      type: SnackBarType.info,
      duration: duration,
      action: action,
    );
  }

  // Helper methods
  static Widget _buildContent(String message, TextStyle style) {
    return Text(
      message,
      style: style,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  static Duration _getDefaultDuration(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return const Duration(seconds: 3);
      case SnackBarType.error:
        return const Duration(seconds: 4);
      case SnackBarType.warning:
        return const Duration(seconds: 4);
      case SnackBarType.info:
        return const Duration(seconds: 3);
    }
  }

  static Color _getDefaultColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Colors.green;
      case SnackBarType.error:
        return AppColors.mainRed;
      case SnackBarType.warning:
        return Colors.orange;
      case SnackBarType.info:
        return AppColors.mainBlue;
    }
  }

  static TextStyle _getDefaultStyle(SnackBarType type) {
    return getRegularStyle(
      fontSize: 14,
      color: AppColors.white,
    );
  }

  static EdgeInsetsGeometry _getDefaultMargin(SnackBarBehavior behavior) {
    if (behavior == SnackBarBehavior.floating) {
      return const EdgeInsets.all(16);
    }
    return EdgeInsets.zero;
  }

  static double _getDefaultElevation(SnackBarType type) {
    switch (type) {
      case SnackBarType.error:
        return 8.0;
      case SnackBarType.warning:
        return 6.0;
      case SnackBarType.success:
      case SnackBarType.info:
        return 4.0;
    }
  }

  static ShapeBorder _getDefaultShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    );
  }
}

// Backward compatibility function
void showSnackBar({
  required BuildContext context,
  required String message,
  Color? backgroundColor,
  TextStyle? style,
}) {
  AppSnackBar.show(
    context: context,
    message: message,
    backgroundColor: backgroundColor,
    style: style,
  );
}
