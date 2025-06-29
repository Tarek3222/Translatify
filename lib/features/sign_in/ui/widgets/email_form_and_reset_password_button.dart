import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:translator/core/widgets/app_elevated_button.dart';
import 'package:translator/features/sign_up/ui/widgets/email_field.dart';

class EmailFormAndResetPasswordButton extends StatefulWidget {
  const EmailFormAndResetPasswordButton({super.key});

  @override
  State<EmailFormAndResetPasswordButton> createState() =>
      _EmailFormAndResetPasswordButtonState();
}

class _EmailFormAndResetPasswordButtonState
    extends State<EmailFormAndResetPasswordButton> {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Expanded(
        child: Column(
          children: [
            EmailField(
              emailController: emailController,
            ),
            const Spacer(),
            AppElevatedButton(
              onPressed: () {
                // verfiyThenResetPassword(context);
              },
              text: 'resetPassword'.tr(),
            ),
            // const ForgetPasswordBlocListener(),
          ],
        ),
      ),
    );
  }

  // void verfiyThenResetPassword(BuildContext context) async {
  //   if (formKey.currentState!.validate()) {
  //     context
  //         .read<ForgetPasswordCubit>()
  //         .forgetPassword(email: emailController.text.trim());
  //   }
  // }
}
