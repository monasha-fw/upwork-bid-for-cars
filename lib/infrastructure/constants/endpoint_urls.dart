abstract class EndpointUrls {
  static const String baseUrl = String.fromEnvironment('BASE_URL', defaultValue: "");

  /// Auth
  static const String loginUserEmail = "/api/auth/login";
}
