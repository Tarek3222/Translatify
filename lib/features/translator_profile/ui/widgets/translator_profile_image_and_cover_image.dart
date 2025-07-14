import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/features/user_profile/ui/widgets/circle_profile_image.dart';
import 'package:translator/features/user_profile/ui/widgets/cover_image_background.dart';

class TranslatorProfileImageAndCoverImage extends StatelessWidget {
  const TranslatorProfileImageAndCoverImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const CoverImageBackground(),
        PositionedDirectional(
          top: 90.h,
          start: 20.w,
          child: CircleProfileImage(
            outerRadius: 80.r,
            innerRadius: 75.r,
          ),
        ),
      ],
    );
  }
}
