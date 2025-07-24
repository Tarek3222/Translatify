import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/networking/api_error_model.dart';
import 'package:translators/features/translator_profile/data/models/reviews_response_body.dart';
import 'package:translators/features/translator_profile/data/repos/reviews_repo.dart';
part 'get_reviews_state.dart';

class GetReviewsCubit extends Cubit<GetReviewsState> {
  final ReviewsRepo _reviewsRepo;

  GetReviewsCubit(this._reviewsRepo) : super(GetReviewsInitial());
  List<ReviewModel> _reviews = [];
  int _page = 1;
  final int _limit = 10;
  bool _isFetching = false;
  bool _hasMore = true;

  Future<void> getReviews(
      {bool refresh = false, required String translatorId}) async {
    if (_isFetching) return;
    _isFetching = true;

    if (refresh) {
      _page = 1;
      _reviews = [];
      _hasMore = true;
      emit(GetReviewsLoading());
    } else {
      emit(GetReviewsLoading());
    }
    final newReviews = await _reviewsRepo.getReviews(
        translatorID: translatorId, limit: _limit, page: _page);
    _isFetching = false;
    newReviews.fold(
      (failure) => emit(
        GetReviewsError(errorModel: failure),
      ),
      (reviewsList) {
        if (reviewsList.isEmpty) {
          _hasMore = false;
        } else {
          _reviews.addAll(reviewsList);
          _page++;
        }
        emit(
          GetReviewsSuccess(
              reviewsList: List.from(_reviews), hasMore: _hasMore),
        );
      },
    );
  }
}
