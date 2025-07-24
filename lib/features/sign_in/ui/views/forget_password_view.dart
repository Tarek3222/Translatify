import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/helpers/spacing.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';
import 'package:translators/features/sign_in/ui/widgets/email_form_and_reset_password_button.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'forgetPassword'.tr(),
                style: getBoldStyle(
                  fontSize: 24.sp,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              verticalSpacing(8),
              Text(
                'securityMessage'.tr(),
                style: getRegularStyle(
                  fontSize: 14.sp,
                  overflow: TextOverflow.visible,
                  color: AppColors.grey,
                ),
              ),
              verticalSpacing(36),
              const EmailFormAndResetPasswordButton(),
            ],
          ),
        ),
      ),
    );
  }
}
