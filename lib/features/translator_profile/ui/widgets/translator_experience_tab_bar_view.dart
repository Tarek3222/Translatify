import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/routing/routes.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';
import 'package:translators/features/home/data/models/translator_response_model.dart';

class TranslatorExperienceTabBarView extends StatelessWidget {
  const TranslatorExperienceTabBarView(
      {super.key, required this.translatorProfileModel});
  final TranslatorProfileModel translatorProfileModel;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitleAndSubtitleText(context, "Experience Years",
              "${translatorProfileModel.translator!.first.experienceYears}"),
          buildTitleAndSubtitleText(
            context,
            "Languages",
            translatorProfileModel.translator!.first.language!.join(', '),
          ),
          buildTitleAndSubtitleText(
            context,
            "Type",
            translatorProfileModel.translator!.first.type!.join(', '),
          ),
          // cv
          buildTextButton('Translator CV', () {
            context.pushNamed(Routes.cvViewerView,
                arguments:
                    translatorProfileModel.translator!.first.cv!.secureUrl!);
          }),
          Text(
            "Certificates : ",
            style: getSemiBoldStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          // certificates
          Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: translatorProfileModel.translator!.first.certifications!
                .map(
                  (certificate) => TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      context.pushNamed(Routes.cvViewerView,
                          arguments: certificate.secureUrl!);
                    },
                    child: Text(
                      'Certificate${translatorProfileModel.translator!.first.certifications!.indexOf(certificate) + 1}',
                      style: getSemiBoldStyle(
                        fontSize: 16,
                        color: AppColors.mainBlue,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  TextButton buildTextButton(String title, void Function() onPressed) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: getSemiBoldStyle(fontSize: 18, color: AppColors.mainBlue),
      ),
    );
  }

  Widget buildTitleAndSubtitleText(
      BuildContext context, String title, String subtitle) {
    return Row(
      children: [
        Text(
          "$title : ",
          style: getSemiBoldStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        Text(
          subtitle,
          style: getRegularStyle(
            fontSize: 14.sp,
            color: AppColors.grey,
          ),
        ),
      ],
    );
  }
}
