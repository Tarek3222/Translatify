// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';
import 'package:translators/features/home/ui/widgets/title_text_widet.dart';
import 'package:translators/features/sign_up/logic/resend_confirm_email/resend_confirm_email_cubit.dart';

class ResendOtpButtonAndBlocConsumer extends StatelessWidget {
  const ResendOtpButtonAndBlocConsumer({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResendConfirmEmailCubit, ResendConfirmEmailState>(
      listener: (context, state) {
        if (state is ResendConfirmEmailSuccess) {
          customDialog(context,
              title: "Success", message: "OTP send successfully");
        } else if (state is ResendConfirmEmailError) {
          customDialog(context,
              title: "Error",
              message: state.errorModel.getAllMessages(),
              color: AppColors.mainRed);
        }
      },
      builder: (context, state) {
        return state is ResendConfirmEmailLoading
            ? const CircularProgressIndicator(
                color: AppColors.mainBlue,
                strokeWidth: 2,
              )
            : InkWell(
                onTap: () async {
                  await context
                      .read<ResendConfirmEmailCubit>()
                      .resendConfirmEmail(email);
                },
                child: Text(
                  "Resend",
                  style: getRegularStyle(
                    fontSize: 15,
                    decoration: TextDecoration.underline,
                    color: AppColors.mainBlue,
                  ),
                ),
              );
      },
    );
  }

  void customDialog(BuildContext context,
      {required String title, required String message, Color? color}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: TitleTextWidet(
          title: title,
          textColor: color,
        ),
        content: Text(
          message,
          style: getRegularStyle(
            fontSize: 15,
            color: AppColors.grey,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(
              "OK",
              style: getSemiBoldStyle(
                fontSize: 16,
                color: color ?? AppColors.mainBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
