// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/theme/app_styles.dart';

class FilterWidgetTranslatorItem extends StatelessWidget {
  const FilterWidgetTranslatorItem(
      {super.key,
      required this.title,
      required this.index,
      required this.selectedIndex});
  final String title;
  final int index;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsetsDirectional.only(start: index == 0 ? 0 : 8.w),
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        color: index == selectedIndex
            ? AppColors.mainBlue
            : Colors.blueAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        title,
        style: getSemiBoldStyle(
          color: index == selectedIndex ? Colors.white : AppColors.mainBlue,
          fontSize: 18,
        ),
      ),
    );
  }
}
