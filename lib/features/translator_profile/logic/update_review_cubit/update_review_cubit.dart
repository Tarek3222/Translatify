import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/networking/api_error_model.dart';
import 'package:translators/features/translator_profile/data/models/review_request_body.dart';
import 'package:translators/features/translator_profile/data/repos/reviews_repo.dart';
part 'update_review_state.dart';

class UpdateReviewCubit extends Cubit<UpdateReviewState> {
  final ReviewsRepo _reviewsRepo;

  UpdateReviewCubit(this._reviewsRepo) : super(UpdateReviewInitial());
  TextEditingController commentController = TextEditingController();
  double rating = 0;

  Future<void> updateReview({required String reviewID}) async {
    ReviewRequestBody reviewRequestBody = ReviewRequestBody(
      rating: rating,
      comment: commentController.text.trim(),
    );
    emit(UpdateReviewLoading());
    final result = await _reviewsRepo.updateReview(reviewID, reviewRequestBody);
    result.fold(
        (failure) => emit(
              UpdateReviewError(errorModel: failure),
            ), (suucess) {
      emit(
        UpdateReviewSuccess(),
      );
    });
  }

  @override
  Future<void> close() {
    commentController.dispose();
    return super.close();
  }
}
