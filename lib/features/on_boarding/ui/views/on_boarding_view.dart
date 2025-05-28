import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/helpers/spacing.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/theme/app_styles.dart';
import 'package:translator/core/widgets/app_elevated_button.dart';
import 'package:translator/features/on_boarding/ui/views/widgets/change_language_and_theme_row.dart';
import 'package:translator/features/on_boarding/ui/views/widgets/onboarding_image_and_text.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  OnboardingViewState createState() => OnboardingViewState();
}

class OnboardingViewState extends State<OnBoardingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10).r,
          child: Column(
            children: [
              const ChangeLanguageAndThemeRow(),
              const Spacer(),
              const OnboardingImageAndText(),
              const Spacer(),
              FadeInRight(
                delay: const Duration(milliseconds: 500),
                child: Text(
                  context.tr('Welcome to Translators'),
                  textAlign: TextAlign.center,
                  style: getRegularStyle(
                    fontSize: 16,
                    color: AppColors.grey,
                  ),
                ),
              ),
              const Spacer(
                flex: 2,
              ),
              ElasticIn(
                delay: const Duration(milliseconds: 600),
                child: AppElevatedButton(
                  onPressed: () {},
                  text: context.tr('Login'),
                ),
              ),
              verticalSpacing(15),
              ElasticIn(
                delay: const Duration(milliseconds: 700),
                child: AppElevatedButton(
                  onPressed: () {},
                  text: context.tr('Sign Up'),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
