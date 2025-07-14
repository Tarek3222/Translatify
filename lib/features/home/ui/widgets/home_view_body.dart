import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/helpers/spacing.dart';
import 'package:translator/features/home/ui/widgets/find_translator_by_type_section.dart';
import 'package:translator/features/home/ui/widgets/find_translators_by_language_section.dart';
import 'package:translator/features/home/ui/widgets/home_sliver_app_bar.dart';
import 'package:translator/features/home/ui/widgets/recommended_translators_sliver_list.dart';
import 'package:translator/features/home/ui/widgets/title_text_widet.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 5)
              .w,
      child: CustomScrollView(
        slivers: [
          const HomeSliverAppBar(),
          const SliverToBoxAdapter(
            child: FindTranslatorsByLanguageSection(),
          ),
          const SliverToBoxAdapter(
            child: FindTranslatorByTypeSection(),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpacing(15),
                const TitleTextWidet(title: "Recommended Translators"),
                verticalSpacing(10),
              ],
            ),
          ),
          const RecommendedTranslatorsSliverList(),
        ],
      ),
    );
  }
}
