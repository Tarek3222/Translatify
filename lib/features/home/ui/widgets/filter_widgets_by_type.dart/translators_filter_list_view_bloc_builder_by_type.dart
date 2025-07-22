// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/features/home/logic/get_translators_list_cubit/get_translators_list_cubit.dart';
import 'package:translator/features/home/ui/widgets/title_text_widet.dart';
import 'package:translator/features/home/ui/widgets/translators_filtered_list_view.dart';

class TranslatorsFilterListViewBlocBuilderByType extends StatelessWidget {
  const TranslatorsFilterListViewBlocBuilderByType({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTranslatorsListCubit, GetTranslatorsListState>(
      buildWhen: (previous, current) =>
          current is GetTranslatorsListFilteredByTypeSuccess ||
          current is GetTranslatorsListFilteredByTypeError,
      builder: (context, state) {
        switch (state.runtimeType) {
          case GetTranslatorsListFilteredByTypeSuccess:
            final successState =
                state as GetTranslatorsListFilteredByTypeSuccess;
            return TranslatorsFilteredListView(
              translatorsList: successState.filteredTranslatorsList,
            );
          case GetTranslatorsListFilteredByTypeError:
            final errorState = state as GetTranslatorsListFilteredByTypeError;
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
