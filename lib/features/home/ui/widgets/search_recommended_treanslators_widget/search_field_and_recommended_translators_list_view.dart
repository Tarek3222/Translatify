// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/helpers/spacing.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/widgets/app_text_form_field.dart';
import 'package:translators/features/home/data/models/translator_response_model.dart';
import 'package:translators/features/home/logic/filter_translators_cubit/filter_translators_cubit.dart';
import 'package:translators/features/home/ui/widgets/recommended_translators_widgets/translator_sliver_list_item.dart';
import 'package:translators/features/home/ui/widgets/search_recommended_treanslators_widget/filter_selection.dart';
import 'package:translators/features/home/ui/widgets/title_text_widet.dart';

class SearchFieldAndRecommendedTranslatorsListView extends StatefulWidget {
  const SearchFieldAndRecommendedTranslatorsListView(
      {super.key, required this.translatorsList});
  final List<TranslatorProfileModel> translatorsList;

  @override
  State<SearchFieldAndRecommendedTranslatorsListView> createState() =>
      _SearchFieldAndRecommendedTranslatorsListViewState();
}

class _SearchFieldAndRecommendedTranslatorsListViewState
    extends State<SearchFieldAndRecommendedTranslatorsListView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 16).w,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: AppTextFormField(
                  hintText: "Search Translators...",
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.mainBlue,
                  ),
                  onChanged: (value) {
                    context.read<FilterTranslatorsCubit>().searchQuery = value;
                    context
                        .read<FilterTranslatorsCubit>()
                        .filterTranslators(translators: widget.translatorsList);
                  },
                ),
              ),
              horizontalSpacing(16),
              InkWell(
                onTap: () {
                  final filterTranslatorCubit =
                      context.read<FilterTranslatorsCubit>();
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    builder: (context) {
                      return FilterSelection(
                        filterTranslatorCubit: filterTranslatorCubit,
                        translatorsList: widget.translatorsList,
                      );
                    },
                  );
                },
                child: Icon(
                  Icons.filter_list,
                  color: AppColors.mainBlue,
                  size: 30.sp,
                ),
              ),
            ],
          ),
          verticalSpacing(16),
          Expanded(
            child: BlocBuilder<FilterTranslatorsCubit, FilterTranslatorsState>(
              buildWhen: (previous, current) =>
                  current is FilterTranslatorsSuccess ||
                  current is FilterTranslatorsError,
              builder: (context, state) {
                switch (state.runtimeType) {
                  case FilterTranslatorsSuccess:
                    return ListView.builder(
                      itemCount: (state as FilterTranslatorsSuccess)
                          .translatorsList
                          .length,
                      itemBuilder: (context, index) {
                        return TranslatorSliverListItem(
                          translatorProfileModel: state.translatorsList[index],
                        );
                      },
                    );
                  case FilterTranslatorsError:
                    return Center(
                      child: TitleTextWidet(
                        title: (state as FilterTranslatorsError).errorMessage,
                        textColor: Colors.red,
                      ),
                    );
                  default:
                    return const SizedBox.shrink();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
