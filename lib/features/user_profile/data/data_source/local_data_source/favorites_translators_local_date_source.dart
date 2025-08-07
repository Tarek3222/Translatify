import 'dart:convert';
import 'dart:developer';

import 'package:translators/core/di/depandecy_injection.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/helpers/shared_preference_helper.dart';
import 'package:translators/features/home/data/models/translator_response_model.dart';

class FavoritesTranslatorsLocalDateSource {
  /// Add Translator to Favorite
  static Future<void> addTranslatorToFavorites(
      String key, TranslatorProfileModel translator) async {
    final favorites = getFavoritesTranslators(key);
    favorites.add(translator);
    final jsonList = favorites.map((t) => jsonEncode(t.toJson())).toList();
    log(jsonList.toString());
    await getIt<SharedPrefHelper>().setList(key, jsonList);
  }

  ///  Get All Favorite Translators
  static List<TranslatorProfileModel> getFavoritesTranslators(String key) {
    final jsonList = getIt<SharedPrefHelper>().getList(key);
    if (!jsonList.isNullOrEmpty()) {
      return jsonList!
          .map(
            (jsonStr) => TranslatorProfileModel.fromJson(
              jsonDecode(jsonStr),
            ),
          )
          .toList();
    } else {
      return [];
    }
  }

  ///  Check if Translator is in Favorites
  static bool isTranslatorInFavorites(String key, String translatorId) {
    final favorites = getFavoritesTranslators(key);
    return favorites
        .any((translator) => translator.translator!.first.id == translatorId);
  }

  ///  Delete Translator from Favorites
  static Future<void> deleteTranslatorFromFavorites(
      String key, String translatorId) async {
    final favorites = getFavoritesTranslators(key);

    favorites.removeWhere(
        (translator) => translator.translator!.first.id == translatorId);

    final jsonList =
        favorites.map((translator) => jsonEncode(translator.toJson())).toList();
    await getIt<SharedPrefHelper>().setList(key, jsonList);
  }

  ///  Clear All Favorites
  static Future<void> clearAll(String key) async {
    await getIt<SharedPrefHelper>().removeData(key);
  }
}
