import 'package:flutter/material.dart';
import 'package:translator/features/translator_profile/ui/widgets/reviews_tab_bar.dart';
import 'package:translator/features/translator_profile/ui/widgets/translator_about_me_tab_view.dart';
import 'package:translator/features/translator_profile/ui/widgets/translator_experience_tab_bar_view.dart';

class CustomTabBarView extends StatelessWidget {
  const CustomTabBarView({super.key, required this.tabController});

  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: const [
        TranslatorAboutMeTabView(),
        TranslatorExperienceTabBarView(),
        ReviewsTabBar(),
      ],
    );
  }
}
