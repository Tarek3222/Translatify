import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/helpers/extensions.dart';
import 'package:translator/core/theme/app_colors.dart';

class CustomAppIcon extends StatelessWidget {
  const CustomAppIcon({
    super.key,
    this.icon,
  });
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.pop();
      },
      style: IconButton.styleFrom(
        backgroundColor: Colors.white,
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
        color: AppColors.mainBlue,
      ),
    );
  }
}
