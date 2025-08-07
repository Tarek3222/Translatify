import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/features/home/logic/filter_translators_cubit/filter_translators_cubit.dart';
import 'package:translators/features/home/ui/widgets/filter_widget_translator_item.dart';

class FilterListViewType extends StatefulWidget {
  const FilterListViewType({super.key, required this.filterTranslatorCubit});
  final FilterTranslatorsCubit filterTranslatorCubit;

  @override
  State<FilterListViewType> createState() => _FilterListViewTypeState();
}

class _FilterListViewTypeState extends State<FilterListViewType> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    selectedIndex = types.indexOf(widget.filterTranslatorCubit.type);
    return SizedBox(
      height: 40.h,
      child: ListView.builder(
          itemCount: types.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            return InkWell(
              onTap: () {
                if (selectedIndex != index) {
                  widget.filterTranslatorCubit.type = types[index];
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
            );
          }),
    );
  }
}

final List<String> types = [
  'All',
  'emergency',
  'editorial',
  'immediate',
];
