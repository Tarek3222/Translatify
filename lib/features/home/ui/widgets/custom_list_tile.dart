import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/theme/app_styles.dart';
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
      leading: CircleAvatar(
        radius: 30.r,
        backgroundImage: NetworkImage(
          imageUrl,
        ),
      ),
      title: TitleTextWidet(
        title: title,
        textColor: textColor,
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
