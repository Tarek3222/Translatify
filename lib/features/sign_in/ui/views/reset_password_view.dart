import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/helpers/spacing.dart';
import 'package:translators/core/theme/app_styles.dart';
import 'package:translators/core/widgets/app_elevated_button.dart';
import 'package:translators/core/widgets/app_snack_bar.dart';
import 'package:translators/features/sign_in/logic/reset_password_cubit/reset_password_cubit.dart';
import 'package:translators/features/sign_in/ui/widgets/reset_password_bloc_listener.dart';
import 'package:translators/features/sign_up/ui/widgets/custom_otp_field.dart';
import 'package:translators/features/sign_up/ui/widgets/label_form.dart';
import 'package:translators/features/sign_up/ui/widgets/password_field.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key, required this.email});
  final String email;

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  var formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    context.read<ResetPasswordCubit>().email = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
          child: Form(
            key: formKey,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reset Password'.tr(),
                        style: getBoldStyle(
                          fontSize: 24.sp,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      verticalSpacing(36),
                      LabelForm(labelText: "password".tr()),
                      verticalSpacing(8),
                      PasswordField(
                        passwordController: context
                            .read<ResetPasswordCubit>()
                            .passwordController,
                      ),
                      verticalSpacing(16),
                      LabelForm(labelText: "confirmPassword".tr()),
                      verticalSpacing(8),
                      PasswordField(
                        passwordController: context
                            .read<ResetPasswordCubit>()
                            .confirmPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'pleaseEnterConfirmPassword'.tr();
                          }
                          if (value !=
                              context
                                  .read<ResetPasswordCubit>()
                                  .passwordController
                                  .text) {
                            return 'passwordNotMatch'.tr();
                          }
                          return null;
                        },
                      ),
                      verticalSpacing(16),
                      LabelForm(labelText: "Otp Code".tr()),
                      verticalSpacing(8),
                      CustomOtpField(
                        onSubmit: (String verificationCode) {
                          log('otp is $verificationCode');
                          context.read<ResetPasswordCubit>().code =
                              verificationCode;
                        },
                      ),
                      const ResetPasswordBlocListener(),
                    ],
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: AppElevatedButton(
                      onPressed: () {
                        if (context.read<ResetPasswordCubit>().code.isEmpty) {
                          showSnackBar(
                              context: context,
                              message: "pleaseEnterOtpCode".tr());
                        }
                        if (formKey.currentState!.validate() &&
                            context
                                .read<ResetPasswordCubit>()
                                .code
                                .isNotEmpty) {
                          context.read<ResetPasswordCubit>().resetPassword();
                        }
                      },
                      text: 'Reset Password'.tr(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
