import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/routing/routes.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/utils/app_constants.dart';
import 'package:translators/features/home/data/models/translator_response_model.dart';
import 'package:translators/features/home/ui/widgets/custom_list_tile.dart';

class TranslatorFilteredItem extends StatelessWidget {
  const TranslatorFilteredItem({super.key, required this.translator});
  final TranslatorProfileModel translator;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(
          Routes.translatorProfileScreen,
          arguments: translator,
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        width: 230.w,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12).w,
        decoration: BoxDecoration(
          color: AppColors.lightBlue,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: CustomListTitle(
          imageUrl: translator.profilePic?.secureUrl ??
              AppConstants.unKnownImageTranslator,
          title: translator.name ?? "Unknown Translator",
          subtitle:
              "${translator.translator!.first.averageRating} ⭐  years ex: ${translator.translator!.first.experienceYears}",
          textColor: AppColors.darkBlue,
        ),
      ),
    );
  }
}
