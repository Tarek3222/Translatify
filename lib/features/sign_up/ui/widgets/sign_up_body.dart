import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/theme/app_styles.dart';
import 'package:translator/features/sign_up/ui/widgets/check_box_and_terms_and_privacy_policy_text.dart';
import 'package:translator/features/sign_up/ui/widgets/sign_up_form_and_sign_up_button.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24).w,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20.h,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10).w,
              child: Text(
                "Sign Up".tr(),
                style: getBoldStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            const SignUpFormAndSignupButton(),
            const CheckBoxAndTermsAndPrivacyPolicyText(),
          ],
        ),
      ),
    );
  }
}
