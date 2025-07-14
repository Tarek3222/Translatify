import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/helpers/spacing.dart';
import 'package:translator/features/translator_profile/ui/widgets/custom_tab_bar_tabs.dart';
import 'package:translator/features/translator_profile/ui/widgets/custom_tab_bar_view.dart';

class TranslatorTabBarSection extends StatefulWidget {
  const TranslatorTabBarSection({super.key});

  @override
  State<TranslatorTabBarSection> createState() =>
      _TranslatorTabBarSectionState();
}

class _TranslatorTabBarSectionState extends State<TranslatorTabBarSection>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5).w,
        child: Column(
          children: [
            CustomTabBarTabs(tabController: tabController),
            verticalSpacing(16),
            Expanded(
              child: CustomTabBarView(tabController: tabController),
            ),
          ],
        ),
      ),
    );
  }
}
