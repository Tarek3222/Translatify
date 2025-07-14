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
            "type of translator",
            "Interpreter",
          ),
          buildTitleAndSubtitleText(
            "Mobile Number",
            "0123456789",
          ),
          buildTitleAndSubtitleText(
            "Date of Birth",
            "01/01/2000",
          ),
          buildTitleAndSubtitleText("Age", "21"),
          buildTitleAndSubtitleText(
            "Gender",
            "Male",
          ),
          buildTitleAndSubtitleText(
            "Location",
            "London, UK",
          ),
        ],
      ),
    );
  }

  Widget buildTitleAndSubtitleText(String title, String subtitle) {
    return Row(
      children: [
        Text(
          "$title : ",
          style: getSemiBoldStyle(
            fontSize: 16,
            color: AppColors.darkBlue,
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
