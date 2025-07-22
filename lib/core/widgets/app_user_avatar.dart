import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/helpers/extensions.dart';
import 'package:translator/core/theme/app_styles.dart';
import 'package:translator/core/widgets/app_circle_cached_network_image.dart';

class AppUserAvatar extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final double fontSize;
  final double radius;

  const AppUserAvatar({
    super.key,
    this.imageUrl,
    required this.radius,
    required this.name,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final initials = _getInitials(name);

    return imageUrl.isNullOrEmpty()
        ? CircleAvatar(
            radius: radius.r,
            backgroundColor: _getColorFromName(name),
            child: Text(
              initials,
              style: getSemiBoldStyle(
                color: Colors.white,
                fontSize: fontSize,
              ),
            ),
          )
        : AppCircleCachedNetworkImage(
            imageUrl: imageUrl!,
            radius: radius,
          );
  }

  /// Get first two letters from name
  String _getInitials(String name) {
    if (name.trim().isEmpty) return '?';
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return (parts[0][0] + parts[1][0]).toUpperCase();
    }
    return name.substring(0, name.length >= 2 ? 2 : 1).toUpperCase();
  }

  /// Generate consistent color from name
  Color _getColorFromName(String name) {
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.brown,
      Colors.pink,
    ];
    int hash = name.codeUnits.fold(0, (prev, element) => prev + element);
    return colors[hash % colors.length];
  }
}
