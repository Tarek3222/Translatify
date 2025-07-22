part of 'add_review_cubit.dart';

sealed class AddReviewState extends Equatable {
  const AddReviewState();

  @override
  List<Object> get props => [];
}

final class AddReviewInitial extends AddReviewState {}

final class AddReviewLoading extends AddReviewState {}

final class AddReviewSuccess extends AddReviewState {}

final class AddReviewError extends AddReviewState {
  final ApiErrorModel errorModel;
  const AddReviewError({required this.errorModel});

  @override
  List<Object> get props => [errorModel];
}
