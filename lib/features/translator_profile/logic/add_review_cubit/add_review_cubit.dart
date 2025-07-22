import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/core/helpers/extensions.dart';
import 'package:translator/core/networking/api_error_model.dart';
import 'package:translator/features/translator_profile/data/models/review_request_body.dart';
import 'package:translator/features/translator_profile/data/repos/reviews_repo.dart';
part 'add_review_state.dart';

class AddReviewCubit extends Cubit<AddReviewState> {
  final ReviewsRepo _reviewsRepo;

  AddReviewCubit(this._reviewsRepo) : super(AddReviewInitial());
  TextEditingController commentController = TextEditingController();
  double rating = 0;

  Future<void> addReview({required String translatorId}) async {
    ReviewRequestBody reviewRequestBody = ReviewRequestBody(
      rating: rating,
      comment: commentController.text.isNullOrEmpty()
          ? " "
          : commentController.text.trim(),
    );
    emit(AddReviewLoading());
    final result =
        await _reviewsRepo.addReview(translatorId, reviewRequestBody);
    result.fold(
        (failure) => emit(
              AddReviewError(errorModel: failure),
            ), (suucess) {
      emit(
        AddReviewSuccess(),
      );
    });
  }

  @override
  Future<void> close() {
    commentController.dispose();
    rating = 0;
    return super.close();
  }
}
