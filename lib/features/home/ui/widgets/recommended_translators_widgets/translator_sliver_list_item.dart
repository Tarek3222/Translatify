import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/helpers/spacing.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/theme/app_styles.dart';
import 'package:translator/core/utils/app_constants.dart';
import 'package:translator/core/widgets/app_cached_network_image.dart';
import 'package:translator/features/home/data/models/translator_response_model.dart';
import 'package:translator/features/home/ui/widgets/title_text_widet.dart';

class TranslatorSliverListItem extends StatelessWidget {
  const TranslatorSliverListItem({
    super.key,
    required this.translatorProfileModel,
  });
  final TranslatorProfileModel translatorProfileModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          AppCachedNetworkImage(
            imageUrl: translatorProfileModel.profilePic?.secureUrl ??
                AppConstants.unKnownImageTranslator,
            width: 110,
            height: 110,
          ),
          horizontalSpacing(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleTextWidet(
                    title: translatorProfileModel.name ?? "Unknown Translator"),
                verticalSpacing(5),
                Text(
                  "${translatorProfileModel.translator?.first.averageRating} ⭐  years ex: ${translatorProfileModel.translator?.first.experienceYears}",
                  style: getRegularStyle(
                    color: AppColors.grey,
                    fontSize: 14,
                  ),
                ),
                verticalSpacing(5),
                Text(
                  "phone: ${translatorProfileModel.mobileNumber ?? "Unknown"}",
                  style: getRegularStyle(
                    color: AppColors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
