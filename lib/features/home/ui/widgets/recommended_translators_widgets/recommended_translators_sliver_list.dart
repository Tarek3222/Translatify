import 'package:flutter/material.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/routing/routes.dart';
import 'package:translators/features/home/data/models/translator_response_model.dart';
import 'package:translators/features/home/ui/widgets/recommended_translators_widgets/translator_sliver_list_item.dart';

class RecommendedTranslatorsSliverList extends StatelessWidget {
  const RecommendedTranslatorsSliverList(
      {super.key, required this.translatorsList});
  final List<TranslatorProfileModel> translatorsList;
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: translatorsList.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          context.pushNamed(
            Routes.translatorProfileScreen,
            arguments: translatorsList[index],
          );
        },
        child: TranslatorSliverListItem(
          translatorProfileModel: translatorsList[index],
        ),
      ),
    );
  }
}
