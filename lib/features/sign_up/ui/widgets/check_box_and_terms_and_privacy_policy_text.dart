import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';
import 'package:translators/features/sign_up/ui/widgets/custom_check_box.dart';

class CheckBoxAndTermsAndPrivacyPolicyText extends StatelessWidget {
  const CheckBoxAndTermsAndPrivacyPolicyText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomCheckBox(),
        const SizedBox(width: 8),
        Expanded(child: buildTermsAndPrivacyPolicyText(context)),
      ],
    );
  }

  Widget buildTermsAndPrivacyPolicyText(BuildContext context) => RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "acceptPrefix".tr(),
              style: getLightStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            TextSpan(
              text: 'termsOfUse'.tr(),
              style: getRegularStyle(
                fontSize: 12,
                color: AppColors.mainBlue,
              ),
            ),
            TextSpan(
              text: ' ${"and".tr()} ',
              style: getLightStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            TextSpan(
              text: 'privacyPolicy'.tr(),
              style: getRegularStyle(
                fontSize: 12,
                color: AppColors.mainBlue,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.start,
      );
}
