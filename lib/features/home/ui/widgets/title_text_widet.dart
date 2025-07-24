import 'package:flutter/material.dart';
import 'package:translators/core/theme/app_styles.dart';

class TitleTextWidet extends StatelessWidget {
  const TitleTextWidet(
      {super.key,
      required this.title,
      this.fontSize,
      this.textColor,
      this.overflow});
  final String title;
  final double? fontSize;
  final Color? textColor;
  final TextOverflow? overflow;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: getSemiBoldStyle(
        color: textColor ?? Theme.of(context).colorScheme.secondary,
        fontSize: fontSize ?? 18,
        overflow: overflow,
      ),
    );
  }
}
