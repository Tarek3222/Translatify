import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/helpers/spacing.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/theme/app_styles.dart';
import 'package:translator/features/home/data/models/translator_response_model.dart';

class TranslatorAboutMeTabView extends StatelessWidget {
  const TranslatorAboutMeTabView(
      {super.key, required this.translatorProfileModel});
  final TranslatorProfileModel translatorProfileModel;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 12.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitleAndSubtitleText(
            context,
            "Mobile Number",
            translatorProfileModel.mobileNumber ?? "Not provided",
          ),
          buildTitleAndSubtitleText(
            context,
            "Date of Birth",
            DateFormat("yyyy-MM-dd").format(
              DateTime.tryParse(translatorProfileModel.dob ?? "") ??
                  DateTime.now(),
            ),
          ),
          buildTitleAndSubtitleText(
            context,
            "Age",
            " ${translatorProfileModel.age ?? "Not provided"}",
          ),
          buildTitleAndSubtitleText(
            context,
            "Gender",
            translatorProfileModel.gender ?? "Not provided",
          ),
          buildTitleAndSubtitleText(
            context,
            "Location",
            translatorProfileModel.translator?.first.location ?? "Not provided",
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
