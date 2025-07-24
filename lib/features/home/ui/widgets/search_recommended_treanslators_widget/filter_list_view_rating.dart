import 'package:flutter/material.dart';
import 'package:translators/features/home/logic/filter_translators_cubit/filter_translators_cubit.dart';
import 'package:translators/features/home/ui/widgets/filter_widget_translator_item.dart';

class FilterListViewRating extends StatefulWidget {
  const FilterListViewRating({super.key, required this.filterTranslatorCubit});
  final FilterTranslatorsCubit filterTranslatorCubit;
  @override
  State<FilterListViewRating> createState() => _FilterListViewRatingState();
}

class _FilterListViewRatingState extends State<FilterListViewRating> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    selectedIndex = stars.indexOf(widget.filterTranslatorCubit.rating);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: IntrinsicHeight(
        child: Row(
          children: List.generate(
            stars.length,
            (index) => InkWell(
              onTap: () {
                if (selectedIndex != index) {
                  widget.filterTranslatorCubit.rating = stars[index];
                  setState(() {
                    selectedIndex = index;
                  });
                }
              },
              child: FilterWidgetTranslatorItem(
                title: stars[index],
                index: index,
                selectedIndex: selectedIndex,
                icon: Icons.star,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

List<String> stars = [
  'All',
  '5',
  '4',
  '3',
  '2',
  '1',
  '0',
];
