import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:translators/core/theme/app_colors.dart';

class AppCachedNetworkImage extends StatelessWidget {
  const AppCachedNetworkImage({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.fit,
    this.borderRadius,
    this.errorWidget,
    this.placeholder,
    this.memCacheWidth,
    this.memCacheHeight,
    this.maxWidthDiskCache,
    this.maxHeightDiskCache,
    this.cacheKey,
    this.fadeInDuration = const Duration(milliseconds: 300),
    this.fadeOutDuration = const Duration(milliseconds: 300),
    this.fadeInCurve = Curves.easeIn,
    this.fadeOutCurve = Curves.easeOut,
  });

  final String imageUrl;
  final double width;
  final double height;
  final BoxFit? fit;
  final BorderRadiusGeometry? borderRadius;
  final Widget Function(BuildContext, String, dynamic)? errorWidget;
  final Widget Function(BuildContext, String)? placeholder;
  final int? memCacheWidth;
  final int? memCacheHeight;
  final int? maxWidthDiskCache;
  final int? maxHeightDiskCache;
  final String? cacheKey;
  final Duration fadeInDuration;
  final Duration fadeOutDuration;
  final Curve fadeInCurve;
  final Curve fadeOutCurve;

  @override
  Widget build(BuildContext context) {
    // Validate URL to prevent unnecessary network calls
    if (imageUrl.isEmpty) {
      return _buildEmptyErrorWidget();
    }

    return CachedNetworkImage(
      key: cacheKey != null ? ValueKey(cacheKey) : null,
      imageUrl: imageUrl,
      cacheKey: cacheKey,
      memCacheWidth: memCacheWidth,
      memCacheHeight: memCacheHeight,
      maxWidthDiskCache: maxWidthDiskCache,
      maxHeightDiskCache: maxHeightDiskCache,
      fadeInDuration: fadeInDuration,
      fadeOutDuration: fadeOutDuration,
      fadeInCurve: fadeInCurve,
      fadeOutCurve: fadeOutCurve,
      placeholder: placeholder ??
          (context, url) => _buildShimmerPlaceholder(context, url),
      errorWidget: errorWidget ??
          (context, url, error) => _buildErrorWidget(context, url, error),
      imageBuilder: _buildImageContainer,
      // Add HTTP headers for better caching
      httpHeaders: const {
        'Cache-Control': 'max-age=31536000', // 1 year cache
      },
    );
  }

  Widget _buildShimmerPlaceholder(BuildContext context, String url) {
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
  }

  Widget _buildErrorWidget(BuildContext context, String url, dynamic error) {
    return Container(
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: borderRadius ?? BorderRadius.circular(12.0),
        color: AppColors.lightGrey,
      ),
      child: Icon(
        Icons.error_outline,
        color: Colors.grey[600],
        size: 24.sp,
      ),
    );
  }

  Widget _buildEmptyErrorWidget() {
    return Container(
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: borderRadius ?? BorderRadius.circular(12.0),
        color: AppColors.lightGrey,
      ),
      child: Icon(
        Icons.error_outline,
        color: Colors.grey[600],
        size: 24.sp,
      ),
    );
  }

  Widget _buildImageContainer(
      BuildContext context, ImageProvider imageProvider) {
    return Container(
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: borderRadius ?? BorderRadius.circular(12.0),
        image: DecorationImage(
          image: imageProvider,
          fit: fit ?? BoxFit.cover,
          // Add filter quality for better performance
          filterQuality: FilterQuality.medium,
        ),
      ),
    );
  }
}
