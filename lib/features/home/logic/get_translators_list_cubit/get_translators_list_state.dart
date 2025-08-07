part of 'get_translators_list_cubit.dart';

sealed class GetTranslatorsListState extends Equatable {
  const GetTranslatorsListState();

  @override
  List<Object> get props => [];
}

final class GetTranslatorsListInitial extends GetTranslatorsListState {}

final class GetTranslatorsListLoading extends GetTranslatorsListState {}

final class GetTranslatorsListSuccess extends GetTranslatorsListState {
  final List<TranslatorProfileModel> translatorsList;
  const GetTranslatorsListSuccess({required this.translatorsList});

  @override
  List<Object> get props => [translatorsList];
}

final class GetTranslatorsListError extends GetTranslatorsListState {
  final ApiErrorModel errorModel;
  const GetTranslatorsListError({required this.errorModel});

  @override
  List<Object> get props => [errorModel];
}

// for filter translators by language
final class GetTranslatorsListFilteredByLanguageSuccess
    extends GetTranslatorsListState {
  final List<TranslatorProfileModel> filteredTranslatorsList;
  const GetTranslatorsListFilteredByLanguageSuccess(
      {required this.filteredTranslatorsList});
  @override
  List<Object> get props => [filteredTranslatorsList];
}

final class GetTranslatorsListFilteredByLanguageError
    extends GetTranslatorsListState {
  final String errorMessage;
  const GetTranslatorsListFilteredByLanguageError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

// for filter translators by Type
final class GetTranslatorsListFilteredByTypeSuccess
    extends GetTranslatorsListState {
  final List<TranslatorProfileModel> filteredTranslatorsList;
  const GetTranslatorsListFilteredByTypeSuccess(
      {required this.filteredTranslatorsList});
  @override
  List<Object> get props => [filteredTranslatorsList];
}

final class GetTranslatorsListFilteredByTypeError
    extends GetTranslatorsListState {
  final String errorMessage;
  const GetTranslatorsListFilteredByTypeError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
