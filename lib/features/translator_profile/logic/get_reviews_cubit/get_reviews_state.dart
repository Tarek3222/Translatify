part of 'get_reviews_cubit.dart';

sealed class GetReviewsState extends Equatable {
  const GetReviewsState();

  @override
  List<Object> get props => [];
}

final class GetReviewsInitial extends GetReviewsState {}

final class GetReviewsLoading extends GetReviewsState {}

final class GetReviewsSuccess extends GetReviewsState {
  final List<ReviewModel> reviewsList;
  final bool hasMore;

  const GetReviewsSuccess({required this.reviewsList, required this.hasMore});

  @override
  List<Object> get props => [reviewsList, hasMore];
}

final class GetReviewsError extends GetReviewsState {
  final ApiErrorModel errorModel;
  const GetReviewsError({required this.errorModel});

  @override
  List<Object> get props => [errorModel];
}
