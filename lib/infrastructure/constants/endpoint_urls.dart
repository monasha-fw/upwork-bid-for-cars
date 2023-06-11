abstract class EndpointUrls {
  static const String baseUrl = String.fromEnvironment('BASE_URL', defaultValue: "");

  /// Auth
  static const String loginUserEmail = "/api/auth/login";
  static const String refreshTokens = "/api/auth/refresh";
  static const String registerUserEmail = "/api/auth/register";
  static const String forgottenPasswordResetRequest = "/api/auth/forgotPassword";
  static const String resetPassword = "/api/auth/resetPassword";
  static const String resendVerificationCode = "/api/auth/resendVerificationCode";

  /// Cars
  static const String getCars = "/api/cars";
}
