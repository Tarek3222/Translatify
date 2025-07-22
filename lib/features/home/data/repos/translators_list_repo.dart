import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:translator/core/networking/api_error_handler.dart';
import 'package:translator/core/networking/api_error_model.dart';
import 'package:translator/core/networking/api_service.dart';
import 'package:translator/core/networking/network_info.dart';
import 'package:translator/features/home/data/date_source/local_data_source/translators_list_local_data_source.dart';
import 'package:translator/features/home/data/models/translator_response_model.dart';

class TranslatorsListRepo {
  final ApiService _apiService;
  final NetworkInfo _networkInfo;
  final TranslatorsListLocalDataSource _translatorsListLocalDataSource;
  TranslatorsListRepo(this._apiService, this._networkInfo,
      this._translatorsListLocalDataSource);

  Future<Either<ApiErrorModel, List<TranslatorProfileModel>>>
      getTranslatorsList() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _apiService.getTranslatorsList();
        final translatorResponse =
            TranslatorResponseModel.fromJson(jsonDecode(response));
        // Cache the translators list locally
        await _translatorsListLocalDataSource.cacheTranslatorsList(
            translatorsList: translatorResponse.translators);
        return Right(translatorResponse.translators ?? []);
      } catch (e) {
        return Left(ApiErrorHandler.handle(e));
      }
    } else {
      try {
        final localData =
            await _translatorsListLocalDataSource.getTranslatorsListCached();
        return Right(localData);
      } catch (e) {
        return Left(
          ApiErrorModel(message: e.toString()),
        );
      }
    }
  }
}
