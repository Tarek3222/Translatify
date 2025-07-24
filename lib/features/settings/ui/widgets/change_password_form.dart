import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/helpers/spacing.dart';
import 'package:translators/features/settings/logic/change_password_cubit/change_password_cubit.dart';
import 'package:translators/features/settings/ui/widgets/change_password_bloc_listener.dart';
import 'package:translators/features/sign_up/ui/widgets/label_form.dart';
import 'package:translators/features/sign_up/ui/widgets/password_field.dart';

class ChangePasswordForm extends StatelessWidget {
  const ChangePasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24).w,
      child: Form(
        key: context.read<ChangePasswordCubit>().formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LabelForm(labelText: "Current Password"),
            PasswordField(
              passwordController:
                  context.read<ChangePasswordCubit>().currentPasswordController,
              hintText: "Enter your current password",
              validator: (value) {
                if (value.isNullOrEmpty()) {
                  return "Please enter your current password";
                }
                return null;
              },
            ),
            verticalSpacing(24),
            const LabelForm(labelText: "New Password"),
            PasswordField(
              passwordController:
                  context.read<ChangePasswordCubit>().newPasswordController,
              hintText: "Enter your new password",
            ),
            verticalSpacing(24),
            const LabelForm(labelText: "Confirm Password"),
            PasswordField(
              passwordController:
                  context.read<ChangePasswordCubit>().confirmPasswordController,
              hintText: "Confirm your new password",
              validator: (value) {
                if (value.isNullOrEmpty()) {
                  return "Please confirm your new password";
                }
                if (context
                        .read<ChangePasswordCubit>()
                        .newPasswordController
                        .text !=
                    context
                        .read<ChangePasswordCubit>()
                        .confirmPasswordController
                        .text) {
                  return "Passwords do not match";
                }
                return null;
              },
            ),
            const ChangePasswordBlocListener(),
          ],
        ),
      ),
    );
  }
}
