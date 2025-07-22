// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/features/home/logic/get_translators_list_cubit/get_translators_list_cubit.dart';
import 'package:translator/features/home/ui/widgets/filter_widgets_by_type.dart/filter_widgets_type_list_items.dart';
import 'package:translator/features/home/ui/widgets/filter_widgets_by_type.dart/translators_filter_list_view_bloc_builder_by_type.dart';
import 'package:translator/features/home/ui/widgets/title_text_widet.dart';
import 'package:translator/features/home/ui/widgets/translators_filterd_shimmer_loading.dart';

class TranslatorsFilterByTypeBlocBuilder extends StatelessWidget {
  const TranslatorsFilterByTypeBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTranslatorsListCubit, GetTranslatorsListState>(
      buildWhen: (previous, current) =>
          current is GetTranslatorsListSuccess ||
          current is GetTranslatorsListError ||
          current is GetTranslatorsListLoading,
      builder: (context, state) {
        switch (state.runtimeType) {
          case GetTranslatorsListLoading:
            return setupLoadingState();
          case GetTranslatorsListError:
            return setupErrorState(state);
          case GetTranslatorsListSuccess:
            return setupSuccessState(context);
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }

  Widget setupLoadingState() {
    return const TranslatorsFilterdShimmerLoading();
  }

  Widget setupSuccessState(BuildContext context) {
    context.read<GetTranslatorsListCubit>().filterTranslatorsByType(
          types[0],
        );
    return const TranslatorsFilterListViewBlocBuilderByType();
  }

  Widget setupErrorState(GetTranslatorsListState state) {
    final errorState = state as GetTranslatorsListError;
    return Center(
      child: TitleTextWidet(
        title: errorState.errorModel.getAllMessages(),
        textColor: Colors.red,
      ),
    );
  }
}
