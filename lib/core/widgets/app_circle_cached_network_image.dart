import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/theme/app_colors.dart';

class AppCircleCachedNetworkImage extends StatelessWidget {
  const AppCircleCachedNetworkImage({
    super.key,
    required this.imageUrl,
    required this.radius,
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
  final double radius;
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
      placeholder:
          placeholder ?? (context, url) => _buildPlaceholder(context, url),
      errorWidget: errorWidget ??
          (context, url, error) => _buildErrorWidget(context, url, error),
      imageBuilder: _buildCircleAvatar,
      // Add HTTP headers for better caching
      httpHeaders: const {
        'Cache-Control': 'max-age=31536000', // 1 year cache
      },
    );
  }

  Widget _buildPlaceholder(BuildContext context, String url) {
    return const CircularProgressIndicator();
  }

  Widget _buildErrorWidget(BuildContext context, String url, dynamic error) {
    return CircleAvatar(
      radius: radius.r,
      backgroundColor: AppColors.lightGrey,
      child: Icon(
        Icons.error_outline,
        color: Colors.grey[600],
        size: (radius * 0.4).sp,
      ),
    );
  }

  Widget _buildEmptyErrorWidget() {
    return CircleAvatar(
      radius: radius.r,
      backgroundColor: AppColors.lightGrey,
      child: Icon(
        Icons.error_outline,
        color: Colors.grey[600],
        size: (radius * 0.4).sp,
      ),
    );
  }

  Widget _buildCircleAvatar(BuildContext context, ImageProvider imageProvider) {
    return CircleAvatar(
      radius: radius.r,
      backgroundImage: imageProvider,
      // Add filter quality for better performance
      onBackgroundImageError: (exception, stackTrace) {
        // Handle background image errors gracefully
        debugPrint('Circle avatar image error: $exception');
      },
    );
  }
}
