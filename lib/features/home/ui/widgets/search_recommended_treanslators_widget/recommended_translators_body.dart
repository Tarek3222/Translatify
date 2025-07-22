import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/core/widgets/custom_app_bar.dart';
import 'package:translator/features/home/data/models/translator_response_model.dart';
import 'package:translator/features/home/logic/filter_translators_cubit/filter_translators_cubit.dart';
import 'package:translator/features/home/ui/widgets/search_recommended_treanslators_widget/search_field_and_recommended_translators_list_view.dart';

class RecommendedTranslatorsBody extends StatelessWidget {
  const RecommendedTranslatorsBody(
      {super.key, required this.translatorsList, required this.title});
  final List<TranslatorProfileModel> translatorsList;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          title: title,
        ),
        BlocProvider(
          create: (context) => FilterTranslatorsCubit()
            ..filterTranslators(translators: translatorsList),
          child: Expanded(
            child: SearchFieldAndRecommendedTranslatorsListView(
              translatorsList: translatorsList,
            ),
          ),
        ),
      ],
    );
  }
}
