import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/helpers/spacing.dart';
import 'package:translators/core/widgets/app_elevated_button.dart';
import 'package:translators/features/sign_in/logic/sign_in_cubit/sign_in_cubit.dart';
import 'package:translators/features/sign_in/ui/widgets/forget_password_text.dart';
import 'package:translators/features/sign_in/ui/widgets/sign_in_bloc_listener.dart';
import 'package:translators/features/sign_up/ui/widgets/email_field.dart';
import 'package:translators/features/sign_up/ui/widgets/label_form.dart';
import 'package:translators/features/sign_up/ui/widgets/password_field.dart';

class EmailAndPasswordFieldsAndContinueButton extends StatelessWidget {
  const EmailAndPasswordFieldsAndContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<SignInCubit>().formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelForm(
            labelText: "email".tr(),
          ),
          verticalSpacing(15),
          EmailField(
            emailController: context.read<SignInCubit>().emailController,
          ),
          verticalSpacing(15),
          LabelForm(
            labelText: "password".tr(),
          ),
          verticalSpacing(15),
          PasswordField(
            passwordController: context.read<SignInCubit>().passwordController,
          ),
          verticalSpacing(12),
          const ForgetPasswordText(),
          verticalSpacing(25),
          AppElevatedButton(
            onPressed: () {
              loginUser(context);
            },
            elevation: 0,
            text: 'continue'.tr(),
          ),
          const SignInBlocListener(),
        ],
      ),
    );
  }

  void loginUser(BuildContext context) {
    if (context.read<SignInCubit>().formKey.currentState!.validate()) {
      context.read<SignInCubit>().signInUser();
    }
  }
}
