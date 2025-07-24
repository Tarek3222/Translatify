import 'package:flutter/material.dart';
import 'package:translators/core/helpers/spacing.dart';
import 'package:translators/core/widgets/custom_app_bar.dart';
import 'package:translators/features/home/data/models/translator_response_model.dart';
import 'package:translators/features/translator_profile/ui/widgets/translator_name_and_rate_and_bio_section.dart';
import 'package:translators/features/translator_profile/ui/widgets/translator_profile_image_and_cover_image.dart';
import 'package:translators/features/translator_profile/ui/widgets/translator_tab_bar_section.dart';

class TranslatorProfileBody extends StatelessWidget {
  const TranslatorProfileBody(
      {super.key, required this.translatorProfileModel});
  final TranslatorProfileModel translatorProfileModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAppBar(
            title: translatorProfileModel.name ?? 'Unknown Translator'),
        TranslatorProfileImageAndCoverImage(
          translatorProfileModel: translatorProfileModel,
        ),
        verticalSpacing(50),
        TranslatorNameAndRateAndBioSection(
          translatorProfileModel: translatorProfileModel,
        ),
        TranslatorTabBarSection(
          translatorProfileModel: translatorProfileModel,
        ),
      ],
    );
  }
}
