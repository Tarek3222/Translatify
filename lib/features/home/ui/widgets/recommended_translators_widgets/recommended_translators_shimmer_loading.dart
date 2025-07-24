import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:translators/core/helpers/spacing.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/widgets/app_text_shimmer_loading.dart';

class RecommendedTranslatorsShimmerLoading extends StatelessWidget {
  const RecommendedTranslatorsShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 5,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: Row(
          children: [
            Shimmer.fromColors(
              baseColor: AppColors.lightGrey,
              highlightColor: Colors.white,
              child: Container(
                width: 110.w,
                height: 110.h,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            horizontalSpacing(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppTextShimmerLoading(height: 14, width: 50),
                  verticalSpacing(5),
                  const AppTextShimmerLoading(height: 14, width: 80),
                  verticalSpacing(5),
                  const AppTextShimmerLoading(height: 14, width: 80),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
