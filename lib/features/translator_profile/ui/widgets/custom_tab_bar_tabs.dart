import 'package:flutter/material.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/theme/app_styles.dart';

class CustomTabBarTabs extends StatelessWidget {
  const CustomTabBarTabs({super.key, required this.tabController});
  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      indicatorColor: AppColors.mainBlue,
      labelStyle: getBoldStyle(
        fontSize: 14,
        color: AppColors.mainBlue,
      ),
      unselectedLabelColor: const Color(0xff9E9E9E),
      indicatorAnimation: TabIndicatorAnimation.linear,
      dividerColor: AppColors.lightGrey,
      indicatorSize: TabBarIndicatorSize.tab,
      tabs: const [
        Tab(
          text: "About me",
        ),
        Tab(
          text: "Experience",
        ),
        Tab(
          text: "Reviews",
        ),
      ],
    );
  }
}
