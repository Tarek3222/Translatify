import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:translators/core/theme/app_colors.dart';

class AppCachedNetworkImage extends StatelessWidget {
  const AppCachedNetworkImage(
      {super.key,
      required this.imageUrl,
      required this.width,
      required this.height,
      this.fit,
      this.borderRadius});
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit? fit;
  final BorderRadiusGeometry? borderRadius;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      progressIndicatorBuilder: (context, url, downloadProgress) {
        return Shimmer.fromColors(
          baseColor: AppColors.lightGrey,
          highlightColor: Colors.white,
          child: Container(
            width: width.w,
            height: height.h,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: borderRadius ?? BorderRadius.circular(12.0),
              color: Colors.white,
            ),
          ),
        );
      },
      imageBuilder: (context, imageProvider) => Container(
        width: width.w,
        height: height.h,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: borderRadius ?? BorderRadius.circular(12.0),
          image: DecorationImage(
            image: imageProvider,
            fit: fit ?? BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
