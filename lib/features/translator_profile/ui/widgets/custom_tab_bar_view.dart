import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/core/di/depandecy_injection.dart';
import 'package:translator/features/home/data/models/translator_response_model.dart';
import 'package:translator/features/translator_profile/data/repos/reviews_repo.dart';
import 'package:translator/features/translator_profile/logic/get_reviews_cubit/get_reviews_cubit.dart';
import 'package:translator/features/translator_profile/ui/widgets/reviews_tab_bar_bloc_builder.dart';
import 'package:translator/features/translator_profile/ui/widgets/translator_about_me_tab_view.dart';
import 'package:translator/features/translator_profile/ui/widgets/translator_experience_tab_bar_view.dart';

class CustomTabBarView extends StatelessWidget {
  const CustomTabBarView(
      {super.key,
      required this.tabController,
      required this.translatorProfileModel});

  final TranslatorProfileModel translatorProfileModel;
  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        TranslatorAboutMeTabView(
          translatorProfileModel: translatorProfileModel,
        ),
        TranslatorExperienceTabBarView(
          translatorProfileModel: translatorProfileModel,
        ),
        BlocProvider(
          create: (context) => GetReviewsCubit(getIt<ReviewsRepo>()),
          child: ReviewsTabBarBlocBuilder(
            translatorProfileModel: translatorProfileModel,
          ),
        ),
      ],
    );
  }
}
