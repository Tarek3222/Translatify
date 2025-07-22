// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/helpers/extensions.dart';
import 'package:translator/core/helpers/spacing.dart';
import 'package:translator/core/routing/routes.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/utils/app_constants.dart';
import 'package:translator/core/widgets/custom_app_bar.dart';
import 'package:translator/features/home/ui/widgets/recommended_translators_widgets/translator_sliver_list_item.dart';
import 'package:translator/features/home/ui/widgets/title_text_widet.dart';
import 'package:translator/features/user_profile/logic/translators_favorites_cubit/translators_favorites_cubit.dart';

class TranslatrosFavoritesBody extends StatelessWidget {
  const TranslatrosFavoritesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: CustomAppBar(title: "Favorites"),
            ),
            InkWell(
              onTap: () {
                context
                    .read<TranslatorsFavoritesCubit>()
                    .clearAllTranslators(SharedPrefKeys.kFavoritesListForUser);
              },
              child: Icon(
                Icons.clear_rounded,
                size: 30.w,
                color: AppColors.mainRed,
              ),
            ),
            horizontalSpacing(10),
          ],
        ),
        Expanded(
          child:
              BlocBuilder<TranslatorsFavoritesCubit, TranslatorsFavoritesState>(
            buildWhen: (previous, current) =>
                current is TranslatorsFavoritesEmptyList ||
                current is TranslatorsFavoritesSuccess,
            builder: (context, state) {
              switch (state.runtimeType) {
                case TranslatorsFavoritesEmptyList:
                  return const Center(
                    child: TitleTextWidet(title: "No Favorites Translators"),
                  );
                case TranslatorsFavoritesSuccess:
                  return buildTranslatorsListView(state, context);
                default:
                  return const SizedBox.shrink();
              }
            },
          ),
        )
      ],
    );
  }

  Widget buildTranslatorsListView(
      TranslatorsFavoritesState state, BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context
            .read<TranslatorsFavoritesCubit>()
            .getTranslatorsFromFavorites(SharedPrefKeys.kFavoritesListForUser);
      },
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount:
            (state as TranslatorsFavoritesSuccess).translatorsList.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            background: Container(
              color: AppColors.mainRed,
              margin: const EdgeInsets.symmetric(vertical: 16).w,
            ),
            onDismissed: (dismissDirection) {
              context.read<TranslatorsFavoritesCubit>().deleteTranslators(
                    SharedPrefKeys.kFavoritesListForUser,
                    state.translatorsList[index].translator!.first.id!,
                  );
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8).w,
              child: InkWell(
                onTap: () {
                  context.pushNamed(
                    Routes.translatorProfileScreen,
                    arguments: state.translatorsList[index],
                  );
                },
                child: TranslatorSliverListItem(
                  translatorProfileModel: state.translatorsList[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
