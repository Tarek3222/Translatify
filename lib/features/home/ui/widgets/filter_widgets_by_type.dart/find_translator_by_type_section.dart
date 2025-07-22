import 'package:flutter/material.dart';
import 'package:translator/core/helpers/spacing.dart';
import 'package:translator/features/home/ui/widgets/filter_widgets_by_type.dart/filter_widgets_type_list_items.dart';
import 'package:translator/features/home/ui/widgets/filter_widgets_by_type.dart/translators_filter_by_type_bloc_builder.dart';

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
        const TranslatorsFilterByTypeBlocBuilder(),
      ],
    );
  }
}
