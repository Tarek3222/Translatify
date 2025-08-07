// ignore_for_file: deprecated_member_use

import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';

class OnboardingImageAndText extends StatelessWidget {
  const OnboardingImageAndText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BounceInDown(
      delay: const Duration(milliseconds: 300),
      child: Stack(
        children: [
          Container(
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.surfaceContainer,
                  theme.colorScheme.surfaceContainer.withOpacity(0.0),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: const [0.01, 0.4],
              ),
            ),
            child: Image.asset(
              theme.brightness == Brightness.dark
                  ? 'assets/images/onboard_image.jpg'
                  : 'assets/images/onboarding_image.jpg',
              height: 350.h,
            ),
          ),
          Positioned(
            bottom: 5,
            left: 0,
            right: 0,
            child: Text(
              context.tr("Best Translators Worldwide"),
              style: getBoldStyle(
                fontSize: 24,
                color: AppColors.mainBlue,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
