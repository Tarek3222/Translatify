import 'package:flutter/material.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/theme/app_styles.dart';
import 'package:translator/core/widgets/app_circle_cached_network_image.dart';
import 'package:translator/features/home/ui/widgets/title_text_widet.dart';

class CustomListTitle extends StatelessWidget {
  const CustomListTitle({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    this.textColor,
  });

  final String imageUrl;
  final String title;
  final String subtitle;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: AppCircleCachedNetworkImage(imageUrl: imageUrl, radius: 30),
      title: TitleTextWidet(
        title: title,
        textColor: textColor,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        subtitle,
        style: getRegularStyle(
          color: AppColors.grey,
          fontSize: 14,
        ),
      ),
    );
  }
}
