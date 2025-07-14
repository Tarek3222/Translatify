import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/theme/app_colors.dart';

class CircleProfileImage extends StatelessWidget {
  const CircleProfileImage({
    super.key,
    this.outerRadius,
    this.innerRadius,
  });
  final double? outerRadius;
  final double? innerRadius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: outerRadius ?? 85.r,
      backgroundColor: AppColors.darkBlue,
      child: CircleAvatar(
        radius: innerRadius ?? 80.r,
        backgroundImage: const NetworkImage(
          "https://res.cloudinary.com/dns6iddx7/image/upload/v1747299261/Graduation_Project/Users/et8v/Profile/kr8hf8hpelgdmrxywz60.jpg",
        ),
      ),
    );
  }
}
