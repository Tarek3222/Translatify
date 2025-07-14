import 'package:flutter/material.dart';
import 'package:translator/features/home/ui/widgets/translator_sliver_list_item.dart';

class RecommendedTranslatorsSliverList extends StatelessWidget {
  const RecommendedTranslatorsSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 10,
      itemBuilder: (context, index) => const TranslatorSliverListItem(),
    );
  }
}
