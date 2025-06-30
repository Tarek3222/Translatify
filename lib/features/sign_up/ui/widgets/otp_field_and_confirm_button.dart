import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/core/widgets/app_elevated_button.dart';
import 'package:translator/features/sign_up/logic/confirm_email_cubit/confirm_email_cubit.dart';
import 'package:translator/features/sign_up/ui/widgets/custom_otp_field.dart';
import 'package:translator/features/sign_up/ui/widgets/verify_email_bloc_listener.dart';

class OtpFieldAndConfirmButton extends StatelessWidget {
  const OtpFieldAndConfirmButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          CustomOtpField(
            onSubmit: (String verificationCode) {
              log('otp is $verificationCode');
              context.read<ConfirmEmailCubit>().code = verificationCode;
            },
          ),
          const Spacer(),
          AppElevatedButton(
            onPressed: () {
              if (context.read<ConfirmEmailCubit>().code.isNotEmpty) {
                context.read<ConfirmEmailCubit>().confirmEmail();
              }
            },
            text: 'confirmButton'.tr(),
          ),
          const VerifyEmailBlocListener(),
        ],
      ),
    );
  }
}
