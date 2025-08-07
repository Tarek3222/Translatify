import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

enum LoadingType {
  staggeredDotsWave,
  threeArchedCircle,
  fourRotatingDots,
  threeRotatingDots,
  twoRotatingArc,
  horizontalRotatingDots,
  circularProgress,
}

class AppLoadingIndicator extends StatelessWidget {
  final double? size;
  final Color? color;
  final LoadingType type;
  final bool center;
  final EdgeInsetsGeometry? padding;
  final double? strokeWidth;
  final Duration? duration;

  const AppLoadingIndicator({
    super.key,
    this.size,
    this.color,
    this.type = LoadingType.staggeredDotsWave,
    this.center = true,
    this.padding,
    this.strokeWidth,
    this.duration,
  });

  // Const constructor for common use cases
  const AppLoadingIndicator.small({
    super.key,
    this.color,
    this.type = LoadingType.staggeredDotsWave,
    this.center = true,
    this.padding,
  })  : size = 20,
        strokeWidth = null,
        duration = null;

  // Const constructor for medium size
  const AppLoadingIndicator.medium({
    super.key,
    this.color,
    this.type = LoadingType.staggeredDotsWave,
    this.center = true,
    this.padding,
  })  : size = 40,
        strokeWidth = null,
        duration = null;

  // Const constructor for large size
  const AppLoadingIndicator.large({
    super.key,
    this.color,
    this.type = LoadingType.staggeredDotsWave,
    this.center = true,
    this.padding,
  })  : size = 60,
        strokeWidth = null,
        duration = null;

  // Const constructor for circular progress
  const AppLoadingIndicator.circular({
    super.key,
    this.size,
    this.color,
    this.center = true,
    this.padding,
    this.strokeWidth = 2.0,
  })  : type = LoadingType.circularProgress,
        duration = null;

  @override
  Widget build(BuildContext context) {
    final effectiveSize = size ?? 40.w;
    final effectiveColor = color ?? AppColors.mainBlue;
    final effectiveStrokeWidth = strokeWidth ?? 2.0;
    final effectiveDuration = duration ?? const Duration(milliseconds: 1500);

    Widget loadingWidget = _buildLoadingAnimation(
      effectiveSize,
      effectiveColor,
      effectiveStrokeWidth,
      effectiveDuration,
    );

    if (padding != null) {
      loadingWidget = Padding(
        padding: padding!,
        child: loadingWidget,
      );
    }

    if (center) {
      return Center(child: loadingWidget);
    }

    return loadingWidget;
  }

  Widget _buildLoadingAnimation(
    double size,
    Color color,
    double strokeWidth,
    Duration duration,
  ) {
    switch (type) {
      case LoadingType.staggeredDotsWave:
        return LoadingAnimationWidget.staggeredDotsWave(
          color: color,
          size: size,
        );
      case LoadingType.threeArchedCircle:
        return LoadingAnimationWidget.threeArchedCircle(
          color: color,
          size: size,
        );
      case LoadingType.fourRotatingDots:
        return LoadingAnimationWidget.fourRotatingDots(
          color: color,
          size: size,
        );
      case LoadingType.threeRotatingDots:
        return LoadingAnimationWidget.threeRotatingDots(
          color: color,
          size: size,
        );
      case LoadingType.twoRotatingArc:
        return LoadingAnimationWidget.twoRotatingArc(
          color: color,
          size: size,
        );
      case LoadingType.horizontalRotatingDots:
        return LoadingAnimationWidget.horizontalRotatingDots(
          color: color,
          size: size,
        );
      case LoadingType.circularProgress:
        return SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: strokeWidth,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        );
    }
  }
}

// Backward compatibility alias
class AppLoadingIndecator extends AppLoadingIndicator {
  const AppLoadingIndecator({
    super.key,
    super.size,
    super.color,
    super.type,
    super.center,
    super.padding,
    super.strokeWidth,
    super.duration,
  });
}
