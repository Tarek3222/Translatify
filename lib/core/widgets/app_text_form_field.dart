import 'package:flutter/material.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/theme/app_styles.dart';

class AppTextFormField extends StatelessWidget {
  final InputBorder? foundedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final TextEditingController? controller;
  final Color? backgroundColor;
  final bool? isObscureText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Iterable<String>? autofillHints;
  final void Function(String)? onChanged;
  final AutovalidateMode? autovalidateMode;
  final int? maxLines;
  final int? maxLength;
  final TextAlign? textAlign;
  final FocusNode? focusNode;
  const AppTextFormField({
    super.key,
    this.foundedBorder,
    this.enabledBorder,
    this.maxLines = 1,
    this.validator,
    this.inputTextStyle,
    this.hintStyle,
    this.prefixIcon,
    this.controller,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.keyboardType,
    this.backgroundColor,
    this.autofillHints,
    this.autovalidateMode,
    this.focusNode,
    this.maxLength,
    this.onChanged,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: isObscureText ?? false,
      maxLines: maxLines,
      textAlign: textAlign ?? TextAlign.start,
      style: inputTextStyle ??
          getLightStyle(
            fontSize: 14,
            color: AppColors.darkBlue,
          ),
      autofillHints: autofillHints ?? autofillHints,
      maxLength: maxLength,
      onChanged: onChanged,
      focusNode: focusNode,
      autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        counterText: "",
        fillColor: backgroundColor ?? AppColors.white,
        filled: true,
        isDense: true,
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppColors.mainBlue,
                width: 0.5,
              ),
            ),
        focusedBorder: foundedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppColors.mainBlue,
                width: 0.5,
              ),
            ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 0.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 0.5,
          ),
        ),
        hintStyle: hintStyle ??
            getLightStyle(
              fontSize: 14,
              color: AppColors.darkBlue,
            ),
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
