import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/features/home/data/models/translator_response_model.dart';
import 'package:translators/features/user_profile/data/data_source/local_data_source/favorites_translators_local_date_source.dart';
part 'translators_favorites_state.dart';

class TranslatorsFavoritesCubit extends Cubit<TranslatorsFavoritesState> {
  TranslatorsFavoritesCubit() : super(TranslatorsFavoritesInitial());

  void getTranslatorsFromFavorites(String key) {
    final translatorsList =
        FavoritesTranslatorsLocalDateSource.getFavoritesTranslators(key);
    if (translatorsList.isEmpty) {
      emit(TranslatorsFavoritesEmptyList());
    } else {
      emit(TranslatorsFavoritesSuccess(translatorsList: translatorsList));
    }
  }

  Future<void> clearAllTranslators(String key) async {
    emit(TranslatorsFavoritesLoadingClearAll());
    await FavoritesTranslatorsLocalDateSource.clearAll(key);
    getTranslatorsFromFavorites(key);
  }

  Future<void> deleteTranslators(String key, String translatorId) async {
    await FavoritesTranslatorsLocalDateSource.deleteTranslatorFromFavorites(
        key, translatorId);
    getTranslatorsFromFavorites(key);
  }
}
