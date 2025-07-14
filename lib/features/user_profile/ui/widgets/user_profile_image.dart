import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/features/user_profile/ui/widgets/circle_profile_image.dart';
import 'package:translator/features/user_profile/ui/widgets/custom_camera_icon.dart';

class UserProfileImage extends StatefulWidget {
  const UserProfileImage({super.key});

  @override
  State<UserProfileImage> createState() => _UserProfileImageState();
}

class _UserProfileImageState extends State<UserProfileImage> {
  bool isLeft = true;
  @override
  Widget build(BuildContext context) {
    return AnimatedPositionedDirectional(
      duration: const Duration(milliseconds: 300),
      top: 100.h,
      start: isLeft ? 20.w : MediaQuery.of(context).size.width - 190.w,
      // end: isLeft ? 0 : 1.w,
      child: Stack(
        children: [
          InkWell(
            onTap: () => setState(() => isLeft = !isLeft),
            child: const CircleProfileImage(),
          ),
          PositionedDirectional(
            bottom: 10.h,
            end: 10.w,
            child: const CustomCameraIcon(),
          ),
        ],
      ),
    );
  }
}
