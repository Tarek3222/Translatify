import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:translators/core/theme/app_colors.dart';

class AppTextShimmerLoading extends StatelessWidget {
  const AppTextShimmerLoading(
      {super.key, required this.height, required this.width});
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.lightGrey,
      highlightColor: Colors.white,
      child: Container(
        height: height.h,
        width: width.w,
        decoration: const BoxDecoration(
          color: AppColors.lightGrey,
        ),
      ),
    );
  }
}
