// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/helpers/spacing.dart';
import 'package:translators/core/widgets/app_elevated_button.dart';
import 'package:translators/features/home/logic/get_translators_list_cubit/get_translators_list_cubit.dart';
import 'package:translators/features/home/ui/widgets/recommended_translators_widgets/recommended_translators_shimmer_loading.dart';
import 'package:translators/features/home/ui/widgets/recommended_translators_widgets/recommended_translators_sliver_list.dart';
import 'package:translators/features/home/ui/widgets/title_text_widet.dart';

class RecommendedTranslatorsBlocBuilder extends StatelessWidget {
  const RecommendedTranslatorsBlocBuilder({super.key});

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
            return setupErrorState(state, context);
          case GetTranslatorsListSuccess:
            return setupSuccessState(state);
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }

  Widget setupLoadingState() {
    return const RecommendedTranslatorsShimmerLoading();
  }

  Widget setupSuccessState(GetTranslatorsListState state) {
    final successState = state as GetTranslatorsListSuccess;
    // get the list of translators with rating above 3.0
    final recommendedTranslators = successState.translatorsList
        .where(
            (translator) => translator.translator!.first.averageRating! >= 3.0)
        .toList();
    return RecommendedTranslatorsSliverList(
      translatorsList: recommendedTranslators,
    );
  }

  Widget setupErrorState(GetTranslatorsListState state, BuildContext context) {
    final errorState = state as GetTranslatorsListError;
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Column(
          children: [
            TitleTextWidet(
              title: "Error: ${errorState.errorModel.getAllMessages()}",
              textColor: Colors.red,
            ),
            verticalSpacing(10),
            AppElevatedButton(
              onPressed: () async {
                final cubit = context.read<GetTranslatorsListCubit>();

                // Clear existing data first to free memory
                cubit.clearTranslatorsList(); // Add this method to your cubit

                // Small delay to allow garbage collection
                await Future.delayed(const Duration(milliseconds: 100));

                // Then fetch new data
                await cubit.getTranslatorsList(forceRefresh: true);
              },
              text: "Retry",
            ),
          ],
        ),
      ),
    );
  }
}
