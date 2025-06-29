import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:translator/core/helpers/extensions.dart';
import 'package:translator/core/helpers/spacing.dart';
import 'package:translator/core/routing/routes.dart';
import 'package:translator/core/widgets/app_elevated_button.dart';
import 'package:translator/features/sign_up/ui/widgets/sign_up_form.dart';

class SignUpFormAndSignupButton extends StatelessWidget {
  const SignUpFormAndSignupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const SignUpForm(),
          verticalSpacing(20),
          AppElevatedButton(
            onPressed: () {
              context.pushNamed(Routes.verifyCodeEmail);
            },
            elevation: 0,
            text: 'Sign Up'.tr(),
          ),
        ],
      ),
    );
  }
}
