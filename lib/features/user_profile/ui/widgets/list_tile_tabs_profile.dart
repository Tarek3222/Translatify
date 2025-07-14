import 'package:flutter/material.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/theme/app_styles.dart';

class ListTileTabsProfile extends StatelessWidget {
  const ListTileTabsProfile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.color,
  });
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: color ?? AppColors.darkBlue, size: 30),
      title: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: getMediumStyle(
            color: color ?? AppColors.darkBlue,
            fontSize: 18,
          ),
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: color ?? AppColors.darkBlue,
      ),
    );
  }
}
