// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';

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
  final bool? enabled;
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
    this.enabled,
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
            fontSize: 15,
            color: Theme.of(context).colorScheme.secondary,
          ),
      autofillHints: autofillHints ?? autofillHints,
      maxLength: maxLength,
      onChanged: onChanged,
      enabled: enabled,
      focusNode: focusNode,
      autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        counterText: "",
        fillColor: backgroundColor ?? Theme.of(context).colorScheme.background,
        filled: true,
        isDense: true,
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onPrimary,
                width: 0.8,
              ),
            ),
        focusedBorder: foundedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppColors.mainBlue,
                width: 0.8,
              ),
            ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 0.9,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 0.9,
          ),
        ),
        hintStyle: hintStyle ??
            getLightStyle(
              fontSize: 15,
              color: Theme.of(context).colorScheme.secondary,
            ),
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
