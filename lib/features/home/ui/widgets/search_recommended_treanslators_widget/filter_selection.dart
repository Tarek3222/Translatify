import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/helpers/spacing.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';
import 'package:translators/core/widgets/app_elevated_button.dart';
import 'package:translators/features/home/data/models/translator_response_model.dart';
import 'package:translators/features/home/logic/filter_translators_cubit/filter_translators_cubit.dart';
import 'package:translators/features/home/ui/widgets/search_recommended_treanslators_widget/filter_list_view_languages.dart';
import 'package:translators/features/home/ui/widgets/search_recommended_treanslators_widget/filter_list_view_rating.dart';
import 'package:translators/features/home/ui/widgets/title_text_widet.dart';

import 'filter_list_view_type.dart';

class FilterSelection extends StatelessWidget {
  const FilterSelection(
      {super.key,
      required this.filterTranslatorCubit,
      required this.translatorsList});
  final FilterTranslatorsCubit filterTranslatorCubit;
  final List<TranslatorProfileModel> translatorsList;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16).w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            width: 50.w,
            height: 5.h,
            decoration: BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(8).r,
            ),
          ),
          verticalSpacing(20),
          const TitleTextWidet(title: "Filtered By"),
          verticalSpacing(20),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              "Language",
              style: getSemiBoldStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          verticalSpacing(8),
          FilterListViewLanguages(
            filterTranslatorCubit: filterTranslatorCubit,
          ),
          verticalSpacing(16),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              "type",
              style: getSemiBoldStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          verticalSpacing(8),
          FilterListViewType(
            filterTranslatorCubit: filterTranslatorCubit,
          ),
          verticalSpacing(16),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              "Rating",
              style: getSemiBoldStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          verticalSpacing(8),
          FilterListViewRating(
            filterTranslatorCubit: filterTranslatorCubit,
          ),
          verticalSpacing(30),
          AppElevatedButton(
              onPressed: () {
                filterTranslatorCubit.filterTranslators(
                    translators: translatorsList);
                Navigator.pop(context);
              },
              text: "Done"),
        ],
      ),
    );
  }
}
