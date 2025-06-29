import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:translator/core/helpers/extensions.dart';
import 'package:translator/core/routing/routes.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/theme/app_styles.dart';

class ForgetPasswordText extends StatelessWidget {
  const ForgetPasswordText({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: InkWell(
        onTap: () {
          context.pushNamed(Routes.forgetPassword);
        },
        child: Text(
          'forgotPassword'.tr(),
          style: getMediumStyle(
            fontSize: 13,
            color: AppColors.mainBlue,
          ),
        ),
      ),
    );
  }
}
