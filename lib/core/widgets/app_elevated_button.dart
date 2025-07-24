import 'package:flutter/material.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';

class AppElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final double? height;
  final double? width;
  final OutlinedBorder? shape;
  final String text;
  final double? elevation;
  final TextStyle? textStyle;
  const AppElevatedButton({
    super.key,
    required this.onPressed,
    this.backgroundColor,
    this.height,
    this.width,
    this.shape,
    required this.text,
    this.textStyle,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.mainBlue,
        fixedSize: Size(width ?? double.maxFinite, height ?? 49),
        shape: shape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shadowColor: AppColors.black,
        elevation: elevation ?? 2,
      ),
      child: Text(
        text,
        style: textStyle ??
            getRegularStyle(
              fontSize: 18,
              color: AppColors.white,
            ),
      ),
    );
  }
}
