import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:translators/core/networking/api_constants.dart';
import 'package:translators/features/settings/data/models/update_password_request_body.dart';
import 'package:translators/features/sign_in/data/models/reset_password_request_body.dart';
import 'package:translators/features/sign_in/data/models/sign_in_request_body.dart';
import 'package:translators/features/sign_up/data/models/confirm_email_request_body.dart';
import 'package:translators/features/sign_up/data/models/sign_up_request_body.dart';
import 'package:translators/features/translator_profile/data/models/review_request_body.dart';
import 'package:translators/features/translator_profile/data/models/reviews_response_body.dart';
import 'package:translators/features/user_profile/data/models/update_user_request_body.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) = _ApiService;

  @POST(ApiConstants.signUp)
  Future<String> signUp(@Body() SignUpRequestBody signUpRequestBody);

  @POST(ApiConstants.signInEndpoint)
  Future<String> signIn(@Body() SignInRequestBody signInRequestBody);

  @PUT(ApiConstants.confirmEmail)
  Future<String> confirmEmail(
      @Body() ConfirmEmailRequestBody confirmEmailRequestBody);
  @PUT(ApiConstants.resendConfirmEmailOtpEndpoint)
  Future<String> resendConfirmEmail(@Body() Map<String, dynamic> email);

  @POST(ApiConstants.forgetPasswordEndpoint)
  Future<String> forgetPassword(
      @Path("email") String email, @Body() Map<String, dynamic> emailBody);

  @POST(ApiConstants.resetPasswordEndpoint)
  Future<String> resetPassword(@Path("email") String email,
      @Body() ResetPasswordRequestBody resetPasswordRequestBody);

  // User Profile
  @GET(ApiConstants.userProfileEndpoint)
  Future<String> getUserProfile();

  @DELETE(ApiConstants.deleteUserProfileImageEndpoint)
  Future<String> deleteUserProfileImage();

  @DELETE(ApiConstants.deleteUserCoverImageEndpoint)
  Future<String> deleteUserCoverImage();

  @PUT(ApiConstants.updateUserEndpoint)
  Future<String> updateUser(
      @Body() UpdateUserRequestBody updateUserRequestBody);

  @PATCH(ApiConstants.updatePasswordEndpoint)
  Future<String> updatePassword(
      @Body() UpdatePasswordRequestBody updatePasswordRequestBody);

  @POST(ApiConstants.signOutEndpoint)
  Future<String> signOut();

  @DELETE(ApiConstants.deleteAccountEndpoint)
  Future<String> deleteAccount();

  // Translator Endpoints
  @GET(ApiConstants.translatorsListEndpoint)
  Future<String> getTranslatorsList();

  // Reviews Endpoints
  @POST(ApiConstants.addReviewEndpoint)
  Future<String> addReview(@Path("translatorId") String translatorId,
      @Body() ReviewRequestBody reviewRequestBody);

  @GET(ApiConstants.getReviewsEndpoint)
  Future<ReviewsResponseBody> getReviews(
      @Path("translatorId") String translatorId,
      @Query("page") int page,
      @Query("limit") int limit);

  @DELETE(ApiConstants.deleteReviewEndpoint)
  Future<String> deleteReview(@Path("reviewId") String reviewId);
  @PUT(ApiConstants.updateReviewEndpoint)
  Future<String> updateReview(@Path("reviewId") String reviewId,
      @Body() ReviewRequestBody reviewRequestBody);
}
