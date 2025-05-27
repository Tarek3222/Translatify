import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/theme/font_weight_helper.dart';

TextStyle getRegularStyle({
  double fontSize = 12,
  Color color = AppColors.black,
  TextOverflow? overflow,
}) {
  return TextStyle(
    color: color,
    fontSize: fontSize.sp,
    overflow: overflow,
    fontWeight: FontWeightHelper.regular,
  );
}

TextStyle getMediumStyle({
  double fontSize = 12,
  Color color = AppColors.black,
  TextOverflow? overflow,
}) {
  return TextStyle(
    color: color,
    fontSize: fontSize.sp,
    overflow: overflow,
    fontWeight: FontWeightHelper.medium,
  );
}

TextStyle getLightStyle({
  double fontSize = 12,
  Color color = AppColors.black,
  TextOverflow? overflow,
}) {
  return TextStyle(
    color: color,
    fontSize: fontSize.sp,
    overflow: overflow,
    fontWeight: FontWeightHelper.light,
  );
}

TextStyle getSemiBoldStyle({
  double fontSize = 12,
  Color color = AppColors.black,
  TextOverflow? overflow,
}) {
  return TextStyle(
    color: color,
    fontSize: fontSize.sp,
    overflow: overflow,
    fontWeight: FontWeightHelper.semiBold,
  );
}

TextStyle getBoldStyle({
  double fontSize = 12,
  Color color = AppColors.black,
  TextOverflow? overflow,
}) {
  return TextStyle(
    color: color,
    overflow: overflow,
    fontSize: fontSize.sp,
    fontWeight: FontWeightHelper.bold,
  );
}
