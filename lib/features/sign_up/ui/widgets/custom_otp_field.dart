import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:translators/core/theme/app_colors.dart';

class CustomOtpField extends StatelessWidget {
  final void Function(String)? onSubmit;
  final void Function(String)? onCodeChanged;
  const CustomOtpField({super.key, this.onSubmit, this.onCodeChanged});

  @override
  Widget build(BuildContext context) {
    return OtpTextField(
      numberOfFields: 6,
      borderColor: AppColors.mainBlue,
      disabledBorderColor: AppColors.mainBlue,
      enabledBorderColor: AppColors.mainBlue,
      borderWidth: 1.3,
      showFieldAsBox: true,
      //runs when a code is typed in
      onCodeChanged: onCodeChanged,
      //runs when every textfield is filled
      onSubmit: onSubmit, // end onSubmit
    );
  }
}
