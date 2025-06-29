import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/helpers/spacing.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/theme/app_styles.dart';
import 'package:translator/features/sign_up/ui/widgets/otp_field_and_confirm_button.dart';

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
    // context.read<ConfirmEmailCubit>().email = widget.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
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
              const OtpFieldAndConfirmButton(),
            ],
          ),
        ),
      ),
    );
  }
}
