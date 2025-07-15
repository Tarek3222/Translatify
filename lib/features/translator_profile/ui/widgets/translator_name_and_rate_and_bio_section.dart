import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/helpers/spacing.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/theme/app_styles.dart';
import 'package:translator/core/widgets/app_elevated_button.dart';

class TranslatorNameAndRateAndBioSection extends StatelessWidget {
  const TranslatorNameAndRateAndBioSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16).w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Tarek Ahmed",
                style: getSemiBoldStyle(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.favorite,
                color: AppColors.mainBlue,
                size: 30.sp,
              )
            ],
          ),
          verticalSpacing(8),
          Text(
            "3.5 ⭐  (5 reviews)",
            style: getRegularStyle(
              color: AppColors.grey,
              fontSize: 15,
            ),
          ),
          verticalSpacing(8),
          Text(
            "Quick and accurate translations with over 6 years of freelance experience.",
            style: getRegularStyle(
              color: AppColors.grey,
              fontSize: 13,
            ),
          ),
          verticalSpacing(5),
          Row(
            children: [
              Expanded(
                child: AppElevatedButton(
                  onPressed: () {},
                  text: "Add Review",
                  height: 40.h,
                  elevation: 0,
                ),
              ),
              horizontalSpacing(10),
              Expanded(
                child: AppElevatedButton(
                  onPressed: () {},
                  text: "pay Now",
                  height: 40.h,
                  elevation: 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
