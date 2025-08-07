import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/routing/routes.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';

class DontHaveAnAccountText extends StatelessWidget {
  const DontHaveAnAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'dontHaveAccount'.tr(),
            style: getRegularStyle(
              fontSize: 13,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          TextSpan(
            text: ' ${"Sign Up".tr()}',
            style: getRegularStyle(
              fontSize: 13,
              color: AppColors.mainBlue,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.pushNamed(Routes.signUpScreen);
              },
          ),
        ],
      ),
    );
  }
}
