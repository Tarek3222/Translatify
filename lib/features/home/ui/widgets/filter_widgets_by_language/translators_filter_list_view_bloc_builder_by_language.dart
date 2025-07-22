// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/features/home/logic/get_translators_list_cubit/get_translators_list_cubit.dart';
import 'package:translator/features/home/ui/widgets/title_text_widet.dart';
import 'package:translator/features/home/ui/widgets/translators_filtered_list_view.dart';

class TranslatorsFilterListViewBlocBuilderByLanguage extends StatelessWidget {
  const TranslatorsFilterListViewBlocBuilderByLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTranslatorsListCubit, GetTranslatorsListState>(
      buildWhen: (previous, current) =>
          current is GetTranslatorsListFilteredByLanguageSuccess ||
          current is GetTranslatorsListFilteredByLanguageError,
      builder: (context, state) {
        switch (state.runtimeType) {
          case GetTranslatorsListFilteredByLanguageSuccess:
            final successState =
                state as GetTranslatorsListFilteredByLanguageSuccess;
            return TranslatorsFilteredListView(
              translatorsList: successState.filteredTranslatorsList,
            );
          case GetTranslatorsListFilteredByLanguageError:
            final errorState =
                state as GetTranslatorsListFilteredByLanguageError;
            return Center(
              child: TitleTextWidet(
                title: errorState.errorMessage,
                textColor: Colors.red,
              ),
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
