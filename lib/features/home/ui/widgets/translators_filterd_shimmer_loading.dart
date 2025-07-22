import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/widgets/app_text_shimmer_loading.dart';

class TranslatorsFilterdShimmerLoading extends StatelessWidget {
  const TranslatorsFilterdShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 105.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: 230.w,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12).w,
          decoration: BoxDecoration(
            color: AppColors.lightBlue,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: ListTile(
            leading: Shimmer.fromColors(
              baseColor: AppColors.lightGrey,
              highlightColor: Colors.white,
              child: CircleAvatar(
                radius: 30.r,
                backgroundColor: Colors.white,
              ),
            ),
            title: const AppTextShimmerLoading(height: 14, width: 30),
            subtitle: const AppTextShimmerLoading(height: 14, width: 80),
          ),
        ),
        itemCount: 5,
      ),
    );
  }
}
