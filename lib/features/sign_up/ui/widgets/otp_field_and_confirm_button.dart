import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/di/depandecy_injection.dart';
import 'package:translators/core/helpers/spacing.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';
import 'package:translators/core/widgets/app_elevated_button.dart';
import 'package:translators/features/sign_up/data/repos/sign_up_repo.dart';
import 'package:translators/features/sign_up/logic/confirm_email_cubit/confirm_email_cubit.dart';
import 'package:translators/features/sign_up/ui/widgets/custom_otp_field.dart';
import 'package:translators/features/sign_up/ui/widgets/resend_otp_button_and_bloc_consumer.dart';
import 'package:translators/features/sign_up/ui/widgets/verify_email_bloc_listener.dart';

import '../../logic/resend_confirm_email/resend_confirm_email_cubit.dart';

class OtpFieldAndConfirmButton extends StatelessWidget {
  const OtpFieldAndConfirmButton({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          CustomOtpField(
            onSubmit: (String verificationCode) async {
              log('otp is $verificationCode');
              context.read<ConfirmEmailCubit>().code = verificationCode;
              await context.read<ConfirmEmailCubit>().confirmEmail();
            },
            onCodeChanged: (String code) {
              // validate code
            },
          ),
          verticalSpacing(30),
          Text(
            "Didn't receive the code?",
            style: getRegularStyle(
              fontSize: 14,
              color: AppColors.mainBlue,
            ),
          ),
          BlocProvider(
            create: (context) => ResendConfirmEmailCubit(getIt<SignUpRepo>()),
            child: ResendOtpButtonAndBlocConsumer(email: email),
          ),
          const Spacer(),
          AppElevatedButton(
            onPressed: () async {
              if (context.read<ConfirmEmailCubit>().code.isNotEmpty) {
                await context.read<ConfirmEmailCubit>().confirmEmail();
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
