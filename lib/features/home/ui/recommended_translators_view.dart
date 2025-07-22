import 'package:flutter/material.dart';
import 'package:translator/features/home/data/models/translator_response_model.dart';
import 'package:translator/features/home/ui/widgets/search_recommended_treanslators_widget/recommended_translators_body.dart';

class RecommendedTranslatorsView extends StatelessWidget {
  const RecommendedTranslatorsView(
      {super.key, required this.translatorsList, required this.title});
  final List<TranslatorProfileModel> translatorsList;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RecommendedTranslatorsBody(
          translatorsList: translatorsList,
          title: title,
        ),
      ),
    );
  }
}
