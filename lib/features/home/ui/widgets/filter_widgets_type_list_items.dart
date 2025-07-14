import 'package:flutter/material.dart';
import 'package:translator/features/home/ui/widgets/filter_widget_translator_item.dart';

class FilterWidgetsTypeListItems extends StatefulWidget {
  const FilterWidgetsTypeListItems({super.key});

  @override
  State<FilterWidgetsTypeListItems> createState() =>
      _FilterWidgetsTypeListItemsState();
}

class _FilterWidgetsTypeListItemsState
    extends State<FilterWidgetsTypeListItems> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: IntrinsicHeight(
        child: Row(
          children: List.generate(
            types.length,
            (index) => InkWell(
              onTap: () {
                if (selectedIndex != index) {
                  setState(() {
                    selectedIndex = index;
                  });
                }
              },
              child: FilterWidgetTranslatorItem(
                title: types[index],
                index: index,
                selectedIndex: selectedIndex,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final List<String> types = ['emergency', 'editorial', 'immediate'];
