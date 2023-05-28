import 'package:bid_for_cars/infrastructure/constants/endpoint_urls.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

class DioMocks {
  static const String accessToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwiZmlyc3ROYW1lIjoiSm9obiIsImxhc3ROYW1lIjoiRG9lIiwiZW1haWwiOiJ1c2VyQG1haWwuY29tIiwiaWF0IjoxNTE2MjM5MDIyfQ.e0R6TLnfoBXN0Eg2AHz-n3fNI6kzurgt3_BEVU53_ko";

  static void init(DioAdapter dioAdapter) {
    /// Login
    /// Success - 200
    dioAdapter.onPost(
      EndpointUrls.loginUserEmail,
      data: {"email": "user@mail.com", "password": "Qwe12345"},
      (server) => server.reply(
        200,
        {"access_token": accessToken},
        delay: const Duration(milliseconds: 300),
      ),
    );

    /// Fail - 401
    dioAdapter.onPost(
      EndpointUrls.loginUserEmail,
      data: {"email": "user@mail.com", "password": "Qwe123456"},
      (server) => server.reply(
        401,
        'Invalid credentials',
        delay: const Duration(milliseconds: 300),
      ),
    );

    /// Forgot Password [Request]
    /// Success - 204
    dioAdapter.onPost(
      EndpointUrls.forgottenPasswordResetRequest,
      data: {"email": "user@mail.com"},
      (server) => server.reply(204, "", delay: const Duration(milliseconds: 300)),
    );

    /// Failure - 400
    dioAdapter.onPost(
      EndpointUrls.forgottenPasswordResetRequest,
      data: {"email": "someone@mail.com"},
      (server) => server.reply(400, "Invalid email", delay: const Duration(milliseconds: 300)),
    );

    /// Forgot Password [Reset]
    /// Success - 204
    dioAdapter.onPost(
      EndpointUrls.resetPassword,
      data: {"email": "user@mail.com", "code": "123456", "password": "Qwe12345"},
      (server) => server.reply(204, "", delay: const Duration(milliseconds: 300)),
    );

    /// Failure - 400
    dioAdapter.onPost(
      EndpointUrls.resetPassword,
      data: {"email": "user@mail.com", "code": "654321", "password": "Qwe12345"},
      (server) => server.reply(
        400,
        "Invalid verification code",
        delay: const Duration(milliseconds: 300),
      ),
    );

    /// Re-send verification code
    /// Success - 204
    dioAdapter.onPost(
      EndpointUrls.resendVerificationCode,
      data: {"email": "user@mail.com"},
      (server) => server.reply(204, "", delay: const Duration(milliseconds: 300)),
    );
  }
}
