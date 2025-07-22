import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/core/networking/api_error_model.dart';
import 'package:translator/features/home/data/models/translator_response_model.dart';
import 'package:translator/features/home/data/repos/translators_list_repo.dart';
part 'get_translators_list_state.dart';

class GetTranslatorsListCubit extends Cubit<GetTranslatorsListState> {
  final TranslatorsListRepo _translatorsListRepo;
  GetTranslatorsListCubit(this._translatorsListRepo)
      : super(GetTranslatorsListInitial());
  List<TranslatorProfileModel> translatorsList = [];
  bool _dataFetched = false;

  Future<void> getTranslatorsList({bool forceRefresh = false}) async {
    if (_dataFetched && !forceRefresh) return; // ✅ Prevents second API call
    _dataFetched = true;
    emit(GetTranslatorsListLoading());
    final result = await _translatorsListRepo.getTranslatorsList();
    result.fold(
        (failure) => emit(
              GetTranslatorsListError(errorModel: failure),
            ), (translatorsList) {
      this.translatorsList = translatorsList;
      // ✅ Emit success state with the fetched translators list
      emit(
        GetTranslatorsListSuccess(
          translatorsList: translatorsList,
        ),
      );
    });
  }

  void filterTranslatorsByLanguage(String language) {
    if (translatorsList.isEmpty) {
      emit(
        const GetTranslatorsListFilteredByLanguageError(
            errorMessage: "No translators available to filter"),
      );
      return;
    }
    final filteredTranslators = translatorsList
        .where((translator) =>
            translator.translator!.first.language!.contains(language))
        .toList();
    if (filteredTranslators.isEmpty) {
      emit(const GetTranslatorsListFilteredByLanguageError(
          errorMessage: "No translators found for the selected language"));
    } else {
      emit(
        GetTranslatorsListFilteredByLanguageSuccess(
            filteredTranslatorsList: filteredTranslators),
      );
    }
  }

  void filterTranslatorsByType(String type) {
    if (translatorsList.isEmpty) {
      emit(
        const GetTranslatorsListFilteredByTypeError(
            errorMessage: "No translators available to filter"),
      );
      return;
    }
    final filteredTranslators = translatorsList
        .where(
            (translator) => translator.translator!.first.type!.contains(type))
        .toList();
    if (filteredTranslators.isEmpty) {
      emit(const GetTranslatorsListFilteredByTypeError(
          errorMessage: "No translators found for the selected type"));
    } else {
      emit(
        GetTranslatorsListFilteredByTypeSuccess(
          filteredTranslatorsList: filteredTranslators,
        ),
      );
    }
  }
}
