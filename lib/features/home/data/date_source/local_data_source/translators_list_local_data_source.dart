// ignore_for_file: unnecessary_nullable_for_final_variable_declarations

import 'dart:convert';

import 'package:translators/core/di/depandecy_injection.dart';
import 'package:translators/core/helpers/shared_preference_helper.dart';
import 'package:translators/core/utils/app_constants.dart';
import 'package:translators/features/home/data/models/translator_response_model.dart';

class TranslatorsListLocalDataSource {
  Future<void> cacheTranslatorsList(
      {List<TranslatorProfileModel>? translatorsList}) async {
    if (translatorsList != null) {
      await getIt<SharedPrefHelper>().setData(
        SharedPrefKeys.kTranslatorsList,
        json.encode(
            translatorsList.map((translator) => translator.toJson()).toList()),
      );
    } else {
      throw Exception('No Internet Connection');
    }
  }

  Future<List<TranslatorProfileModel>> getTranslatorsListCached() {
    final String? jsonString = getIt<SharedPrefHelper>().getString(
      SharedPrefKeys.kTranslatorsList,
    )!;

    if (jsonString != null) {
      return Future.value(
        (json.decode(jsonString) as List)
            .map((translatorJson) => TranslatorProfileModel.fromJson(
                translatorJson as Map<String, dynamic>))
            .toList(),
      );
    } else {
      throw Exception('No Internet Connection');
    }
  }
}
