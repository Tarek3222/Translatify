import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/features/user_profile/ui/widgets/cover_image_background.dart';
import 'package:translator/features/user_profile/ui/widgets/custom_camera_icon.dart';

class UserCoverImage extends StatelessWidget {
  const UserCoverImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CoverImageBackground().animate().fade().scale().shake(),
        PositionedDirectional(
          top: 10.h,
          end: 10.w,
          child: const CustomCameraIcon(),
        ),
      ],
    );
  }
}
