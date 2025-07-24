import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/utils/app_constants.dart';
import 'package:translators/core/widgets/app_circle_cached_network_image.dart';

class CircleProfileImage extends StatelessWidget {
  const CircleProfileImage({
    super.key,
    this.outerRadius,
    this.innerRadius,
    this.child,
    this.imageUrl,
  });
  final double? outerRadius;
  final double? innerRadius;
  final Widget? child;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: outerRadius ?? 85.r,
      backgroundColor: AppColors.darkBlue,
      child: child ??
          AppCircleCachedNetworkImage(
            radius: innerRadius ?? 80,
            imageUrl: imageUrl ?? AppConstants.unKnownImageTranslator,
          ),
    );
  }
}
