import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/helpers/spacing.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/theme/app_styles.dart';

class TranslatorExperienceTabBarView extends StatelessWidget {
  const TranslatorExperienceTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitleAndSubtitleText(context, "Experience Years", "6"),
          verticalSpacing(12),
          buildTitleAndSubtitleText(
              context, "Languages", "English, Arabic, French"),
          // cv
          buildTextButton('CV Link', () {}),
          // certificates
          buildTextButton('Certificates', () {}),
        ],
      ),
    );
  }

  TextButton buildTextButton(String title, void Function() onPressed) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: getSemiBoldStyle(fontSize: 18, color: AppColors.mainBlue),
      ),
    );
  }

  Widget buildTitleAndSubtitleText(
      BuildContext context, String title, String subtitle) {
    return Row(
      children: [
        Text(
          "$title : ",
          style: getSemiBoldStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        Text(
          subtitle,
          style: getRegularStyle(
            fontSize: 14.sp,
            color: AppColors.grey,
          ),
        ),
      ],
    );
  }
}
