import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/theme/app_colors.dart';

class CustomCameraIcon extends StatelessWidget {
  const CustomCameraIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Icon(
        Icons.camera_alt,
        size: 40.sp,
        color: AppColors.grey,
      ),
    );
  }
}
