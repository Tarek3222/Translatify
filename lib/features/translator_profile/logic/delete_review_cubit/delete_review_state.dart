part of 'delete_review_cubit.dart';

sealed class DeleteReviewState extends Equatable {
  const DeleteReviewState();

  @override
  List<Object> get props => [];
}

final class DeleteReviewInitial extends DeleteReviewState {}

final class DeleteReviewLoading extends DeleteReviewState {}

final class DeleteReviewSuccess extends DeleteReviewState {}

final class DeleteReviewError extends DeleteReviewState {
  final ApiErrorModel errorModel;
  const DeleteReviewError({required this.errorModel});

  @override
  List<Object> get props => [errorModel];
}
