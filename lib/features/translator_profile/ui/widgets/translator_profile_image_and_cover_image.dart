// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/widgets/app_cached_network_image.dart';
import 'package:translator/features/home/data/models/translator_response_model.dart';
import 'package:translator/features/user_profile/ui/widgets/circle_profile_image.dart';

class TranslatorProfileImageAndCoverImage extends StatelessWidget {
  const TranslatorProfileImageAndCoverImage(
      {super.key, required this.translatorProfileModel});
  final TranslatorProfileModel translatorProfileModel;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        translatorProfileModel.coverPic?.secureUrl == null
            ? Container(
                width: double.infinity,
                height: 200.h,
                color: AppColors.grey.withOpacity(0.2),
              )
            : AppCachedNetworkImage(
                imageUrl: translatorProfileModel.coverPic!.secureUrl!,
                width: double.infinity,
                height: 200,
                borderRadius: BorderRadius.zero,
              ),
        PositionedDirectional(
          top: 90.h,
          start: 20.w,
          child: CircleProfileImage(
            outerRadius: 80.r,
            innerRadius: 75,
            imageUrl: translatorProfileModel.profilePic?.secureUrl,
          ),
        ),
      ],
    );
  }
}
