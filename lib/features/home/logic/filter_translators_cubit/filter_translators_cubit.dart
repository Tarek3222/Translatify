import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/features/home/data/models/translator_response_model.dart';
part 'filter_translators_state.dart';

class FilterTranslatorsCubit extends Cubit<FilterTranslatorsState> {
  FilterTranslatorsCubit() : super(FilterTranslatorsInitial());
  List<TranslatorProfileModel> translatorsList = [];

  String language = 'All';
  String rating = 'All';
  String type = 'All';
  String searchQuery = '';
  void filterTranslators({
    required List<TranslatorProfileModel> translators,
  }) {
    translatorsList = translators.where((translator) {
      final matchesLanguage = language == 'All' ||
          translator.translator!.first.language!.contains(language);
      final matchesRating = rating == 'All' ||
          translator.translator!.first.averageRating! >=
              int.parse(rating).toDouble();
      final matchesType =
          type == 'All' || translator.translator!.first.type!.contains(type);
      final matchesSearchQuery = searchQuery.isEmpty ||
          translator.name!.toLowerCase().contains(searchQuery.toLowerCase());

      return matchesLanguage &&
          matchesRating &&
          matchesType &&
          matchesSearchQuery;
    }).toList();

    if (translatorsList.isEmpty) {
      emit(const FilterTranslatorsError(errorMessage: "No translators found"));
    } else {
      emit(FilterTranslatorsSuccess(translatorsList: translatorsList));
    }
  }
}
