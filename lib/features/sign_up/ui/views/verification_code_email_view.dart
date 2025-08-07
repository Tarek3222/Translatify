// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/helpers/spacing.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';
import 'package:translators/features/sign_up/logic/confirm_email_cubit/confirm_email_cubit.dart';
import 'package:translators/features/sign_up/ui/widgets/otp_field_and_confirm_button.dart';

class VerificationEmailCodeView extends StatefulWidget {
  const VerificationEmailCodeView({super.key, required this.email});
  final String email;

  @override
  State<VerificationEmailCodeView> createState() =>
      _VerificationEmailCodeViewState();
}

class _VerificationEmailCodeViewState extends State<VerificationEmailCodeView> {
  @override
  void initState() {
    context.read<ConfirmEmailCubit>().email = widget.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.pop();
        context.pop();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "emailVerificationTitle".tr(),
                  style: getBoldStyle(
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                verticalSpacing(8),
                Text(
                  "emailVerificationSubtitle".tr(),
                  style: getRegularStyle(
                    fontSize: 14,
                    overflow: TextOverflow.visible,
                    color: AppColors.grey,
                  ),
                ),
                verticalSpacing(36),
                OtpFieldAndConfirmButton(
                  email: widget.email,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
