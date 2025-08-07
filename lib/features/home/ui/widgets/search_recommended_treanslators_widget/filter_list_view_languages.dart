import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/features/home/logic/filter_translators_cubit/filter_translators_cubit.dart';
import 'package:translators/features/home/ui/widgets/filter_widget_translator_item.dart';

class FilterListViewLanguages extends StatefulWidget {
  const FilterListViewLanguages(
      {super.key, required this.filterTranslatorCubit});
  final FilterTranslatorsCubit filterTranslatorCubit;

  @override
  State<FilterListViewLanguages> createState() =>
      _FilterListViewLanguagesState();
}

class _FilterListViewLanguagesState extends State<FilterListViewLanguages> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    selectedIndex = languages.indexOf(widget.filterTranslatorCubit.language);
    return SizedBox(
      height: 40.h,
      child: ListView.builder(
          itemCount: languages.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if (selectedIndex != index) {
                  widget.filterTranslatorCubit.language = languages[index];
                  setState(() {
                    selectedIndex = index;
                  });
                }
              },
              child: FilterWidgetTranslatorItem(
                title: languages[index],
                index: index,
                selectedIndex: selectedIndex,
              ),
            );
          }),
    );
  }
}

List<String> languages = [
  'All',
  'English',
  'Chinese',
  'German',
  'Spanish',
  'Italian',
];
