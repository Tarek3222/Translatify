part of 'translators_favorites_cubit.dart';

sealed class TranslatorsFavoritesState extends Equatable {
  const TranslatorsFavoritesState();

  @override
  List<Object> get props => [];
}

final class TranslatorsFavoritesInitial extends TranslatorsFavoritesState {}

final class TranslatorsFavoritesLoadingClearAll
    extends TranslatorsFavoritesState {}

final class TranslatorsFavoritesLoadingDeleteTranslator
    extends TranslatorsFavoritesState {}

final class TranslatorsFavoritesSuccess extends TranslatorsFavoritesState {
  final List<TranslatorProfileModel> translatorsList;

  const TranslatorsFavoritesSuccess({required this.translatorsList});

  @override
  List<Object> get props => [translatorsList];
}

final class TranslatorsFavoritesEmptyList extends TranslatorsFavoritesState {}
