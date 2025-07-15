import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/helpers/spacing.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/theme/app_styles.dart';

class TranslatorAboutMeTabView extends StatelessWidget {
  const TranslatorAboutMeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 12.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitleAndSubtitleText(
            context,
            "type of translator",
            "Interpreter",
          ),
          buildTitleAndSubtitleText(
            context,
            "Mobile Number",
            "0123456789",
          ),
          buildTitleAndSubtitleText(
            context,
            "Date of Birth",
            "01/01/2000",
          ),
          buildTitleAndSubtitleText(context, "Age", "21"),
          buildTitleAndSubtitleText(
            context,
            "Gender",
            "Male",
          ),
          buildTitleAndSubtitleText(
            context,
            "Location",
            "London, UK",
          ),
        ],
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
        verticalSpacing(12),
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
