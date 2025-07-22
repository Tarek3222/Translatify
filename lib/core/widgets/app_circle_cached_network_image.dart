import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:translator/core/theme/app_colors.dart';

class AppCircleCachedNetworkImage extends StatelessWidget {
  const AppCircleCachedNetworkImage(
      {super.key, required this.imageUrl, required this.radius});
  final String imageUrl;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      progressIndicatorBuilder: (context, url, downloadProgress) {
        return Shimmer.fromColors(
          baseColor: AppColors.lightGrey,
          highlightColor: Colors.white,
          child: CircleAvatar(
            radius: radius.r,
            backgroundColor: AppColors.lightGrey,
          ),
        );
      },
      imageBuilder: (context, imageProvider) => CircleAvatar(
        radius: radius.r,
        backgroundImage: imageProvider,
      ),
    );
  }
}
