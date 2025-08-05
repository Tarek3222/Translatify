import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/theme/app_styles.dart';
import 'package:translators/core/widgets/app_circle_cached_network_image.dart';

class AppUserAvatar extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final double fontSize;
  final double radius;
  final Color? backgroundColor;
  final Color? textColor;
  final bool showBorder;
  final Color? borderColor;
  final double? borderWidth;
  final VoidCallback? onTap;
  final String? cacheKey;
  final int? memCacheWidth;
  final int? memCacheHeight;
  final int? maxWidthDiskCache;
  final int? maxHeightDiskCache;

  const AppUserAvatar({
    super.key,
    this.imageUrl,
    required this.radius,
    required this.name,
    required this.fontSize,
    this.backgroundColor,
    this.textColor,
    this.showBorder = false,
    this.borderColor,
    this.borderWidth,
    this.onTap,
    this.cacheKey,
    this.memCacheWidth,
    this.memCacheHeight,
    this.maxWidthDiskCache,
    this.maxHeightDiskCache,
  });

  // Const constructor for small avatars
  const AppUserAvatar.small({
    super.key,
    this.imageUrl,
    required this.name,
    this.backgroundColor,
    this.textColor,
    this.showBorder = false,
    this.borderColor,
    this.borderWidth,
    this.onTap,
    this.cacheKey,
  })  : radius = 20,
        fontSize = 12,
        memCacheWidth = null,
        memCacheHeight = null,
        maxWidthDiskCache = null,
        maxHeightDiskCache = null;

  // Const constructor for medium avatars
  const AppUserAvatar.medium({
    super.key,
    this.imageUrl,
    required this.name,
    this.backgroundColor,
    this.textColor,
    this.showBorder = false,
    this.borderColor,
    this.borderWidth,
    this.onTap,
    this.cacheKey,
  })  : radius = 30,
        fontSize = 16,
        memCacheWidth = null,
        memCacheHeight = null,
        maxWidthDiskCache = null,
        maxHeightDiskCache = null;

  // Const constructor for large avatars
  const AppUserAvatar.large({
    super.key,
    this.imageUrl,
    required this.name,
    this.backgroundColor,
    this.textColor,
    this.showBorder = false,
    this.borderColor,
    this.borderWidth,
    this.onTap,
    this.cacheKey,
  })  : radius = 50,
        fontSize = 24,
        memCacheWidth = null,
        memCacheHeight = null,
        maxWidthDiskCache = null,
        maxHeightDiskCache = null;

  @override
  Widget build(BuildContext context) {
    final effectiveName = name.trim();
    final initials = _getInitials(effectiveName);
    final effectiveCacheKey = cacheKey ?? '${imageUrl}_$radius';

    Widget avatarWidget = imageUrl.isNullOrEmpty()
        ? _buildInitialsAvatar(initials, effectiveName)
        : _buildImageAvatar(effectiveCacheKey);

    if (showBorder) {
      avatarWidget = Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor ?? Theme.of(context).primaryColor,
            width: borderWidth ?? 2.0,
          ),
        ),
        child: avatarWidget,
      );
    }

    if (onTap != null) {
      avatarWidget = GestureDetector(
        onTap: onTap,
        child: avatarWidget,
      );
    }

    return avatarWidget;
  }

  Widget _buildInitialsAvatar(String initials, String name) {
    return CircleAvatar(
      radius: radius.r,
      backgroundColor: backgroundColor ?? _getColorFromName(name),
      child: Text(
        initials,
        style: getSemiBoldStyle(
          color: textColor ?? Colors.white,
          fontSize: fontSize,
        ),
      ),
    );
  }

  Widget _buildImageAvatar(String cacheKey) {
    return AppCircleCachedNetworkImage(
      imageUrl: imageUrl!,
      radius: radius,
      memCacheHeight: memCacheHeight ?? (radius * 2).round(),
      memCacheWidth: memCacheWidth ?? (radius * 2).round(),
      maxHeightDiskCache: maxHeightDiskCache ?? (radius * 4).round(),
      maxWidthDiskCache: maxWidthDiskCache ?? (radius * 4).round(),
      cacheKey: cacheKey,
    );
  }

  /// Get first two letters from name with improved performance
  String _getInitials(String name) {
    if (name.isEmpty) return '?';

    final trimmedName = name.trim();
    if (trimmedName.isEmpty) return '?';

    final parts = trimmedName.split(' ');
    if (parts.length >= 2) {
      final first = parts[0].isNotEmpty ? parts[0][0] : '';
      final second = parts[1].isNotEmpty ? parts[1][0] : '';
      return (first + second).toUpperCase();
    }

    return trimmedName.length >= 2
        ? trimmedName.substring(0, 2).toUpperCase()
        : trimmedName.toUpperCase();
  }

  /// Generate consistent color from name with improved performance
  Color _getColorFromName(String name) {
    if (name.isEmpty) return Colors.grey;

    // Pre-defined colors for better performance
    const colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.brown,
      Colors.pink,
      Colors.indigo,
      Colors.cyan,
      Colors.lime,
      Colors.amber,
    ];

    // Simple hash function for better performance
    int hash = 0;
    for (int i = 0; i < name.length; i++) {
      hash = ((hash << 5) - hash + name.codeUnitAt(i)) & 0xFFFFFFFF;
    }

    return colors[hash.abs() % colors.length];
  }
}
