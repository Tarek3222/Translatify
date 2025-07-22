part of 'update_review_cubit.dart';

sealed class UpdateReviewState extends Equatable {
  const UpdateReviewState();

  @override
  List<Object> get props => [];
}

final class UpdateReviewInitial extends UpdateReviewState {}

final class UpdateReviewLoading extends UpdateReviewState {}

final class UpdateReviewSuccess extends UpdateReviewState {}

final class UpdateReviewError extends UpdateReviewState {
  final ApiErrorModel errorModel;
  const UpdateReviewError({required this.errorModel});

  @override
  List<Object> get props => [errorModel];
}
