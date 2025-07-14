import 'package:flutter/material.dart';
import 'package:translator/core/helpers/spacing.dart';
import 'package:translator/features/home/ui/widgets/filter_widgets_type_list_items.dart';
import 'package:translator/features/home/ui/widgets/translators_filtered_list_view.dart';

class FindTranslatorByTypeSection extends StatelessWidget {
  const FindTranslatorByTypeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpacing(15),
        const FilterWidgetsTypeListItems(),
        verticalSpacing(10),
        const TranslatorsFilteredListView(),
      ],
    );
  }
}
