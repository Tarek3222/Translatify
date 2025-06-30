abstract class ApiConstants {
  static const String baseUrl = "https://translator-project-seven.vercel.app/";

  // Authentication Endpoints
  static const String signUp = "/auth/signup";
  static const String confirmEmail = "/auth/confirm-email";
  static const String forgetPasswordEndpoint = "/auth/forget-password/{email}";
  static const String resetPasswordEndpoint = "/auth/reset-password/{email}";
  static const String signInEndpoint = "/auth/signin";
}
