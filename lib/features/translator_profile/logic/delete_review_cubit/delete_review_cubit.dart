import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/networking/api_error_model.dart';
import 'package:translators/features/translator_profile/data/repos/reviews_repo.dart';
part 'delete_review_state.dart';

class DeleteReviewCubit extends Cubit<DeleteReviewState> {
  final ReviewsRepo _reviewsRepo;

  DeleteReviewCubit(this._reviewsRepo) : super(DeleteReviewInitial());

  Future<void> deleteReview({required String reviewId}) async {
    emit(DeleteReviewLoading());
    final result = await _reviewsRepo.deleteReview(reviewId);
    result.fold(
        (failure) => emit(
              DeleteReviewError(errorModel: failure),
            ), (suucess) {
      emit(
        DeleteReviewSuccess(),
      );
    });
  }
}
