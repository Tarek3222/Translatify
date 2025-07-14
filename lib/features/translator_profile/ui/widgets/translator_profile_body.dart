import 'package:flutter/material.dart';
import 'package:translator/core/helpers/spacing.dart';
import 'package:translator/core/widgets/custom_app_bar.dart';
import 'package:translator/features/translator_profile/ui/widgets/translator_name_and_rate_and_bio_section.dart';
import 'package:translator/features/translator_profile/ui/widgets/translator_profile_image_and_cover_image.dart';
import 'package:translator/features/translator_profile/ui/widgets/translator_tab_bar_section.dart';

class TranslatorProfileBody extends StatelessWidget {
  const TranslatorProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomAppBar(title: "Tarek Ahmed"),
        const TranslatorProfileImageAndCoverImage(),
        verticalSpacing(50),
        const TranslatorNameAndRateAndBioSection(),
        const TranslatorTabBarSection(),
      ],
    );
  }
}
