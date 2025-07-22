import 'package:flutter/material.dart';
import 'package:translator/core/helpers/spacing.dart';
import 'package:translator/features/home/ui/widgets/filter_widgets_by_language/filter_widgets_by_language_list_items.dart';
import 'package:translator/features/home/ui/widgets/filter_widgets_by_language/transtlators_filter_by_language_bloc_builder.dart';

class FindTranslatorsByLanguageSection extends StatelessWidget {
  const FindTranslatorsByLanguageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpacing(15),
        const FilterWidgetsByLanguageListItems(),
        verticalSpacing(10),
        const TranstlatorsFilterByLanguageBlocBuilder(),
      ],
    );
  }
}
