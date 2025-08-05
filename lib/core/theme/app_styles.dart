import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/font_weight_helper.dart';

// Cache for commonly used text styles to avoid repeated creation
class _TextStyleCache {
  static final Map<String, TextStyle> _cache = {};
  static const String _fontFamily = "Cera Pro";

  static TextStyle _createStyle({
    required double fontSize,
    required Color color,
    required FontWeight fontWeight,
    TextOverflow? overflow,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      decoration: decoration,
      color: color,
      fontSize: fontSize.sp,
      overflow: overflow,
      fontFamily: _fontFamily,
      fontWeight: fontWeight,
    );
  }

  static String _generateKey({
    required double fontSize,
    required Color color,
    required FontWeight fontWeight,
    TextOverflow? overflow,
    TextDecoration? decoration,
  }) {
    // ignore: deprecated_member_use
    return '${fontSize}_${color.value}_${fontWeight.index}_${overflow?.index ?? -1}_${decoration?.toString() ?? 'none'}';
  }

  static TextStyle getStyle({
    required double fontSize,
    required Color color,
    required FontWeight fontWeight,
    TextOverflow? overflow,
    TextDecoration? decoration,
  }) {
    final key = _generateKey(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      overflow: overflow,
      decoration: decoration,
    );

    return _cache.putIfAbsent(
        key,
        () => _createStyle(
              fontSize: fontSize,
              color: color,
              fontWeight: fontWeight,
              overflow: overflow,
              decoration: decoration,
            ));
  }

  static void clear() {
    _cache.clear();
  }
}

// Theme-aware text style helper
class AppTextStyles {
  // ignore: unused_field
  static const String _fontFamily = "Cera Pro";

  // Base styles with caching
  static TextStyle getRegularStyle({
    double fontSize = 12,
    Color? color,
    TextOverflow? overflow,
    TextDecoration? decoration,
    BuildContext? context,
  }) {
    final effectiveColor = color ?? _getDefaultColor(context);
    return _TextStyleCache.getStyle(
      fontSize: fontSize,
      color: effectiveColor,
      fontWeight: FontWeightHelper.regular,
      overflow: overflow,
      decoration: decoration,
    );
  }

  static TextStyle getMediumStyle({
    double fontSize = 12,
    Color? color,
    TextOverflow? overflow,
    BuildContext? context,
  }) {
    final effectiveColor = color ?? _getDefaultColor(context);
    return _TextStyleCache.getStyle(
      fontSize: fontSize,
      color: effectiveColor,
      fontWeight: FontWeightHelper.medium,
      overflow: overflow,
    );
  }

  static TextStyle getLightStyle({
    double fontSize = 12,
    Color? color,
    TextOverflow? overflow,
    BuildContext? context,
  }) {
    final effectiveColor = color ?? _getDefaultColor(context);
    return _TextStyleCache.getStyle(
      fontSize: fontSize,
      color: effectiveColor,
      fontWeight: FontWeightHelper.light,
      overflow: overflow,
    );
  }

  static TextStyle getSemiBoldStyle({
    double fontSize = 12,
    Color? color,
    TextOverflow? overflow,
    BuildContext? context,
  }) {
    final effectiveColor = color ?? _getDefaultColor(context);
    return _TextStyleCache.getStyle(
      fontSize: fontSize,
      color: effectiveColor,
      fontWeight: FontWeightHelper.semiBold,
      overflow: overflow,
    );
  }

  static TextStyle getBoldStyle({
    double fontSize = 12,
    Color? color,
    TextOverflow? overflow,
    BuildContext? context,
  }) {
    final effectiveColor = color ?? _getDefaultColor(context);
    return _TextStyleCache.getStyle(
      fontSize: fontSize,
      color: effectiveColor,
      fontWeight: FontWeightHelper.bold,
      overflow: overflow,
    );
  }

  // Theme-aware color selection
  static Color _getDefaultColor(BuildContext? context) {
    if (context != null) {
      return Theme.of(context).colorScheme.onSurface;
    }
    return AppColors.black;
  }

  // Predefined styles for common use cases
  static TextStyle get headlineLarge => getBoldStyle(fontSize: 32);
  static TextStyle get headlineMedium => getBoldStyle(fontSize: 24);
  static TextStyle get headlineSmall => getBoldStyle(fontSize: 20);

  static TextStyle get titleLarge => getSemiBoldStyle(fontSize: 18);
  static TextStyle get titleMedium => getSemiBoldStyle(fontSize: 16);
  static TextStyle get titleSmall => getSemiBoldStyle(fontSize: 14);

  static TextStyle get bodyLarge => getRegularStyle(fontSize: 16);
  static TextStyle get bodyMedium => getRegularStyle(fontSize: 14);
  static TextStyle get bodySmall => getRegularStyle(fontSize: 12);

  static TextStyle get labelLarge => getMediumStyle(fontSize: 14);
  static TextStyle get labelMedium => getMediumStyle(fontSize: 12);
  static TextStyle get labelSmall => getMediumStyle(fontSize: 10);

  // Specialized styles
  static TextStyle get buttonText => getMediumStyle(fontSize: 16);
  static TextStyle get captionText => getLightStyle(fontSize: 12);
  static TextStyle get overlineText => getLightStyle(fontSize: 10);

  // Error and success styles
  static TextStyle get errorText => getRegularStyle(
        fontSize: 12,
        color: AppColors.mainRed,
      );

  static TextStyle get successText => getRegularStyle(
        fontSize: 12,
        color: Colors.green,
      );

  static TextStyle get warningText => getRegularStyle(
        fontSize: 12,
        color: Colors.orange,
      );

  // Clear cache when needed
  static void clearCache() {
    _TextStyleCache.clear();
  }
}

// Backward compatibility functions
TextStyle getRegularStyle({
  double fontSize = 12,
  Color color = AppColors.black,
  TextOverflow? overflow,
  TextDecoration? decoration,
}) {
  return AppTextStyles.getRegularStyle(
    fontSize: fontSize,
    color: color,
    overflow: overflow,
    decoration: decoration,
  );
}

TextStyle getMediumStyle({
  double fontSize = 12,
  Color color = AppColors.black,
  TextOverflow? overflow,
}) {
  return AppTextStyles.getMediumStyle(
    fontSize: fontSize,
    color: color,
    overflow: overflow,
  );
}

TextStyle getLightStyle({
  double fontSize = 12,
  Color color = AppColors.black,
  TextOverflow? overflow,
}) {
  return AppTextStyles.getLightStyle(
    fontSize: fontSize,
    color: color,
    overflow: overflow,
  );
}

TextStyle getSemiBoldStyle({
  double fontSize = 12,
  Color color = AppColors.black,
  TextOverflow? overflow,
}) {
  return AppTextStyles.getSemiBoldStyle(
    fontSize: fontSize,
    color: color,
    overflow: overflow,
  );
}

TextStyle getBoldStyle({
  double fontSize = 12,
  Color color = AppColors.black,
  TextOverflow? overflow,
}) {
  return AppTextStyles.getBoldStyle(
    fontSize: fontSize,
    color: color,
    overflow: overflow,
  );
}
