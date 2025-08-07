// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/features/home/logic/get_translators_list_cubit/get_translators_list_cubit.dart';
import 'package:translators/features/home/ui/widgets/filter_widget_translator_item.dart';

class FilterWidgetsByLanguageListItems extends StatefulWidget {
  const FilterWidgetsByLanguageListItems({super.key});

  @override
  State<FilterWidgetsByLanguageListItems> createState() =>
      _FilterWidgetsByLanguageListItemsState();
}

class _FilterWidgetsByLanguageListItemsState
    extends State<FilterWidgetsByLanguageListItems> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: languages.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if (selectedIndex != index) {
                  context
                      .read<GetTranslatorsListCubit>()
                      .filterTranslatorsByLanguage(
                        languages[index],
                      );
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
  'English',
  'Chinese',
  'German',
  'Spanish',
  'Italian',
];
