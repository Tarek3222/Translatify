import 'dart:convert';
import 'dart:developer';

import 'package:translator/core/di/depandecy_injection.dart';
import 'package:translator/core/helpers/extensions.dart';
import 'package:translator/core/helpers/shared_preference_helper.dart';
import 'package:translator/features/translator_profile/data/models/order_translator_model.dart';

class OrderTranslatorsLocalDataSource {
  /// Add Translator to Favorite
  static Future<void> addTranslatorToOrder(
      String key, OrderTranslatorModel translatorOrder) async {
    final favorites = getOrdersTranslators(key);
    favorites.add(translatorOrder);
    final jsonList = favorites.map((t) => jsonEncode(t.toJson())).toList();
    log(jsonList.toString());
    await getIt<SharedPrefHelper>().setList(key, jsonList);
  }

  ///  Get All Favorite Translators
  static List<OrderTranslatorModel> getOrdersTranslators(String key) {
    final jsonList = getIt<SharedPrefHelper>().getList(key);
    if (!jsonList.isNullOrEmpty()) {
      return jsonList!
          .map(
            (jsonStr) => OrderTranslatorModel.fromJson(
              jsonDecode(jsonStr),
            ),
          )
          .toList();
    } else {
      return [];
    }
  }

  ///  Check if Translator is in Favorites
  static bool isTranslatorInOrders(String key, String translatorId) {
    final favorites = getOrdersTranslators(key);
    return favorites.any((translatorOrder) =>
        translatorOrder.translatorProfileModel.translator!.first.id ==
        translatorId);
  }

  ///  Delete Translator from Favorites
  static Future<void> deleteTranslatorFromOrders(
      String key, String translatorId) async {
    final favorites = getOrdersTranslators(key);

    favorites.removeWhere((translatorOrder) =>
        translatorOrder.translatorProfileModel.translator!.first.id ==
        translatorId);

    final jsonList =
        favorites.map((translator) => jsonEncode(translator.toJson())).toList();
    await getIt<SharedPrefHelper>().setList(key, jsonList);
  }

  ///  Clear All Favorites
  static Future<void> clearAll(String key) async {
    await getIt<SharedPrefHelper>().removeData(key);
  }
}
