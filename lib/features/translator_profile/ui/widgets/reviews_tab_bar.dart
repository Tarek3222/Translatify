import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/features/translator_profile/ui/widgets/single_review_item.dart';

class ReviewsTabBar extends StatelessWidget {
  const ReviewsTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16).r,
          child: const SingleReviewItem(),
        );
      },
    );
  }
}
