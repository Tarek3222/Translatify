abstract class ApiConstants {
  static const String baseUrl = "https://translator-project-seven.vercel.app/";

  // Authentication Endpoints
  static const String signUp = "/auth/signup";
  static const String confirmEmail = "/auth/confirm-email";
  static const String forgetPasswordEndpoint = "/auth/forget-password/{email}";
  static const String resetPasswordEndpoint = "/auth/reset-password/{email}";
  static const String signInEndpoint = "/auth/signin";
  static const String resendConfirmEmailOtpEndpoint =
      "/auth/resend-confirm-email";

  // User Endpoints
  static const String userProfileEndpoint = "/user/get-login-user";
  static const String updateUserProfileImageEndpoint =
      "user/update-profile-pic";
  static const String updateUserCoverImageEndpoint = "user/update-cover-pic";
  static const String deleteUserProfileImageEndpoint =
      "/user/delete-profile-pic";
  static const String deleteUserCoverImageEndpoint = "/user/delete-cover-pic";
  static const String updateUserEndpoint = "/user/update";
  static const String updatePasswordEndpoint = "/user/update-password";
  static const String deleteAccountEndpoint = "/user/soft-delete-account";
  static const String signOutEndpoint = "/auth/signout";

  // Translator Endpoints
  static const String translatorsListEndpoint = "/translator/list";

  //reviews endpoints
  static const String addReviewEndpoint =
      "/review/create-review/{translatorId}";
  static const String getReviewsEndpoint = "/review/get-reviews/{translatorId}";
  static const String deleteReviewEndpoint = "/review/delete-review/{reviewId}";
  static const String updateReviewEndpoint = "/review/update-review/{reviewId}";

  //Chats Endpoints
  static const String getSingleChatEndpoint =
      "/user/get-chat-history/{receiverId}";
  static const String sendMessageEndpoint = "/user/send-message/{receiverId}";
  static const String getListChatsEndpoint = "/user/get-last-chats";
  static const String deleteChatEndpoint =
      "/user/delete-chat-history/{receiverId}";
}
