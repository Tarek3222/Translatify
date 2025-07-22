part of 'filter_translators_cubit.dart';

sealed class FilterTranslatorsState extends Equatable {
  const FilterTranslatorsState();

  @override
  List<Object> get props => [];
}

final class FilterTranslatorsInitial extends FilterTranslatorsState {}

final class FilterTranslatorsSuccess extends FilterTranslatorsState {
  final List<TranslatorProfileModel> translatorsList;
  const FilterTranslatorsSuccess({required this.translatorsList});

  @override
  List<Object> get props => [translatorsList];
}

final class FilterTranslatorsError extends FilterTranslatorsState {
  final String errorMessage;
  const FilterTranslatorsError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
