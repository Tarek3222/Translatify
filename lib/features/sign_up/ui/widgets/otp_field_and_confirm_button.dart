import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/widgets/app_elevated_button.dart';

class OtpFieldAndConfirmButton extends StatelessWidget {
  const OtpFieldAndConfirmButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          OtpTextField(
            numberOfFields: 5,
            borderColor: AppColors.mainBlue,
            disabledBorderColor: AppColors.mainBlue,
            enabledBorderColor: AppColors.mainBlue,
            borderWidth: 1.5,
            showFieldAsBox: true,
            //runs when a code is typed in
            onCodeChanged: (String code) {
              //handle validation or checks here
            },
            //runs when every textfield is filled
            onSubmit: (String verificationCode) {
              log('otp is $verificationCode');
              // context.read<ConfirmEmailCubit>().code = verificationCode;
            }, // end onSubmit
          ),
          const Spacer(),
          AppElevatedButton(
            onPressed: () {
              // if (context.read<ConfirmEmailCubit>().code.isNotEmpty) {
              //   context.read<ConfirmEmailCubit>().confirmEmail();
              // }
            },
            text: 'confirmButton'.tr(),
          ),
          // const VerifyEmailBlocListener(),
        ],
      ),
    );
  }
}
