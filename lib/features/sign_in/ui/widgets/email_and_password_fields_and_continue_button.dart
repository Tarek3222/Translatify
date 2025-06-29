import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:translator/core/helpers/spacing.dart';
import 'package:translator/core/widgets/app_elevated_button.dart';
import 'package:translator/features/sign_in/ui/widgets/forget_password_text.dart';
import 'package:translator/features/sign_up/ui/widgets/email_field.dart';
import 'package:translator/features/sign_up/ui/widgets/label_form.dart';
import 'package:translator/features/sign_up/ui/widgets/password_field.dart';

class EmailAndPasswordFieldsAndContinueButton extends StatefulWidget {
  const EmailAndPasswordFieldsAndContinueButton({super.key});

  @override
  State<EmailAndPasswordFieldsAndContinueButton> createState() =>
      _EmailAndPasswordFieldsAndContinueButtonState();
}

class _EmailAndPasswordFieldsAndContinueButtonState
    extends State<EmailAndPasswordFieldsAndContinueButton> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelForm(
            labelText: "email".tr(),
          ),
          verticalSpacing(15),
          EmailField(
            emailController: emailController,
          ),
          verticalSpacing(15),
          LabelForm(
            labelText: "password".tr(),
          ),
          verticalSpacing(15),
          PasswordField(
            passwordController: passwordController,
          ),
          verticalSpacing(12),
          const ForgetPasswordText(),
          verticalSpacing(25),
          AppElevatedButton(
            onPressed: () {
              // loginUser(context);
            },
            elevation: 0,
            text: 'continue'.tr(),
          ),
          // const LoginBlocListener(),
        ],
      ),
    );
  }

  // void loginUser(BuildContext context) {
  //   if (formKey.currentState!.validate()) {
  //     context.read<LoginCubit>().login(
  //           email: emailController.text.trim(),
  //           password: passwordController.text.trim(),
  //         );
  //   }
  // }
}
