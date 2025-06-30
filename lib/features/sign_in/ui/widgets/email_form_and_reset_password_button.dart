import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/core/widgets/app_elevated_button.dart';
import 'package:translator/features/sign_in/logic/forget_password_cubit/forget_password_cubit.dart';
import 'package:translator/features/sign_in/ui/widgets/forget_password_bloc_listener.dart';
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
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Expanded(
        child: Column(
          children: [
            EmailField(
              emailController:
                  context.read<ForgetPasswordCubit>().emailController,
            ),
            const Spacer(),
            AppElevatedButton(
              onPressed: () {
                forgetPasswordState(context);
              },
              text: 'resetPassword'.tr(),
            ),
            const ForgetPasswordBlocListener(),
          ],
        ),
      ),
    );
  }

  void forgetPasswordState(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      context.read<ForgetPasswordCubit>().forgetPassword();
    }
  }
}
