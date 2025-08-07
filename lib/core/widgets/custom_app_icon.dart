// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/helpers/extensions.dart';

class CustomAppIcon extends StatelessWidget {
  const CustomAppIcon({
    super.key,
    this.icon,
    this.onPressed,
  });
  final IconData? icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return IconButton(
      onPressed: onPressed ??
          () {
            context.pop();
          },
      style: IconButton.styleFrom(
        backgroundColor: theme.colorScheme.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10).r,
          side: const BorderSide(
            color: Color(0xffEDEDED),
            width: 1,
          ),
        ),
      ),
      icon: Icon(
        icon ?? Icons.arrow_back_ios_new_rounded,
        color: theme.colorScheme.secondary,
      ),
    );
  }
}
