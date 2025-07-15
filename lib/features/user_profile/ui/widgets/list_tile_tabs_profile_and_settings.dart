import 'package:flutter/material.dart';
import 'package:translator/core/theme/app_styles.dart';

class ListTileTabsProfileAndSettings extends StatelessWidget {
  const ListTileTabsProfileAndSettings({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.color,
    this.trailing,
  });
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Color? color;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon,
          color: color ?? Theme.of(context).colorScheme.secondary, size: 30),
      title: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: getMediumStyle(
            color: color ?? Theme.of(context).colorScheme.secondary,
            fontSize: 18,
          ),
        ),
      ),
      trailing: trailing ??
          Icon(
            Icons.arrow_forward_ios,
            color: color ?? Theme.of(context).colorScheme.secondary,
          ),
    );
  }
}
