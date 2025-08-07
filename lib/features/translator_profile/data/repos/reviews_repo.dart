import 'package:dartz/dartz.dart';
import 'package:translators/core/networking/api_error_handler.dart';
import 'package:translators/core/networking/api_error_model.dart';
import 'package:translators/core/networking/api_service.dart';
import 'package:translators/features/translator_profile/data/models/review_request_body.dart';
import 'package:translators/features/translator_profile/data/models/reviews_response_body.dart';

class ReviewsRepo {
  final ApiService _apiService;
  ReviewsRepo(this._apiService);

  Future<Either<ApiErrorModel, String>> addReview(
      String translatorId, ReviewRequestBody reviewBody) async {
    try {
      final response = await _apiService.addReview(translatorId, reviewBody);
      return Right(response);
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, String>> updateReview(
      String reviewId, ReviewRequestBody reviewBody) async {
    try {
      final response = await _apiService.updateReview(reviewId, reviewBody);
      return Right(response);
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, String>> deleteReview(String reviewId) async {
    try {
      final response = await _apiService.deleteReview(reviewId);
      return Right(response);
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, List<ReviewModel>>> getReviews(
      {required String translatorID,
      required int page,
      required int limit}) async {
    try {
      final response = await _apiService.getReviews(translatorID, page, limit);
      return Right(response.reviews!);
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }
}
