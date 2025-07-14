import 'package:flutter/material.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/theme/app_styles.dart';

class TitleTextWidet extends StatelessWidget {
  const TitleTextWidet({super.key, required this.title, this.fontSize});
  final String title;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: getSemiBoldStyle(
        color: AppColors.darkBlue,
        fontSize: fontSize ?? 18,
      ),
    );
  }
}
