import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/helpers/spacing.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/theme/app_styles.dart';
import 'package:translator/features/sign_in/ui/widgets/dont_have_an_account_text.dart';
import 'package:translator/features/sign_in/ui/widgets/email_and_password_fields_and_continue_button.dart';
import 'package:translator/features/sign_up/ui/widgets/check_box_and_terms_and_privacy_policy_text.dart';

class SignInBody extends StatelessWidget {
  const SignInBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24).w,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'welcome'.tr(),
                  style: getMediumStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                verticalSpacing(10),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'loginInstruction'.tr(),
                    style: getMediumStyle(
                      fontSize: 12,
                      color: AppColors.grey,
                    ),
                  ),
                ),
                verticalSpacing(20),
                const EmailAndPasswordFieldsAndContinueButton(),
                verticalSpacing(25),
                const CheckBoxAndTermsAndPrivacyPolicyText(),
                verticalSpacing(30),
              ],
            ),
          ),
          const SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: DontHaveAnAccountText(),
            ),
          )
        ],
      ),
    );
  }
}
