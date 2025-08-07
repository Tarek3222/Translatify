import 'package:flutter/material.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';

class AppElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final double? height;
  final double? width;
  final OutlinedBorder? shape;
  final String text;
  final double? elevation;
  final TextStyle? textStyle;
  final bool isLoading;
  final Widget? loadingWidget;
  final Color? disabledColor;
  final EdgeInsetsGeometry? padding;
  final bool enableFeedback;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;
  final WidgetStateProperty<Color?>? overlayColor;
  final WidgetStateProperty<Color?>? foregroundColor;

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
    this.isLoading = false,
    this.loadingWidget,
    this.disabledColor,
    this.padding,
    this.enableFeedback = true,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.overlayColor,
    this.foregroundColor,
  });

  // Const constructor for common use cases
  const AppElevatedButton.primary({
    super.key,
    required this.onPressed,
    required this.text,
    this.height,
    this.width,
    this.isLoading = false,
    this.loadingWidget,
    this.focusNode,
    this.autofocus = false,
  })  : backgroundColor = AppColors.mainBlue,
        shape = null,
        elevation = 2,
        textStyle = null,
        disabledColor = null,
        padding = null,
        enableFeedback = true,
        clipBehavior = Clip.none,
        overlayColor = null,
        foregroundColor = null;

  // Const constructor for secondary buttons
  const AppElevatedButton.secondary({
    super.key,
    required this.onPressed,
    required this.text,
    this.height,
    this.width,
    this.isLoading = false,
    this.loadingWidget,
    this.focusNode,
    this.autofocus = false,
  })  : backgroundColor = Colors.transparent,
        shape = null,
        elevation = 0,
        textStyle = null,
        disabledColor = null,
        padding = null,
        enableFeedback = true,
        clipBehavior = Clip.none,
        overlayColor = null,
        foregroundColor = null;

  @override
  Widget build(BuildContext context) {
    // Early return for loading state to prevent unnecessary rebuilds
    if (isLoading) {
      return _buildLoadingButton();
    }

    return ElevatedButton(
      onPressed: onPressed,
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      style: _buildButtonStyle(),
      child: _buildButtonContent(),
    );
  }

  ButtonStyle _buildButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor ?? AppColors.mainBlue,
      foregroundColor: AppColors.white,
      disabledBackgroundColor: disabledColor ?? AppColors.lightGrey,
      fixedSize: Size(width ?? double.maxFinite, height ?? 49),
      padding: padding,
      shape: shape ??
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shadowColor: AppColors.black,
      elevation: elevation ?? 2,
    );
  }

  Widget _buildButtonContent() {
    return Text(
      text,
      style: textStyle ??
          getRegularStyle(
            fontSize: 18,
            color: AppColors.white,
          ),
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  Widget _buildLoadingButton() {
    return ElevatedButton(
      onPressed: null, // Disable button during loading
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      style: _buildButtonStyle(),
      child: loadingWidget ??
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
            ),
          ),
    );
  }
}
