import 'package:flutter/material.dart';
import 'package:translator/core/theme/app_styles.dart';

class TitleTextWidet extends StatelessWidget {
  const TitleTextWidet(
      {super.key, required this.title, this.fontSize, this.textColor});
  final String title;
  final double? fontSize;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: getSemiBoldStyle(
        color: textColor ?? Theme.of(context).colorScheme.secondary,
        fontSize: fontSize ?? 18,
      ),
    );
  }
}
