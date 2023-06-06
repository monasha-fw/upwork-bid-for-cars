import 'package:bid_for_cars/core/dtos/auth/email_login_dto.dart';
import 'package:bid_for_cars/core/value_objects/value_objects.dart';
import 'package:bid_for_cars/infrastructure/constants/endpoint_urls.dart';
import 'package:bid_for_cars/infrastructure/datasources/remote_datasource/auth_remote_datasource.dart';
import 'package:bid_for_cars/infrastructure/dtos/auth/email_login_model_dto.dart';
import 'package:bid_for_cars/infrastructure/network/http_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_remote_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AppHttpClient>()])
void main() {
  late AuthRemoteDatasourceImpl dataSource;
  late MockAppHttpClient mockAppHttpClient;

  setUp(() {
    mockAppHttpClient = MockAppHttpClient();
    dataSource = AuthRemoteDatasourceImpl(mockAppHttpClient);
  });

  group('loginUserEmail', () {
    final tEmail = EmailAddress("johndoe@mail.com");
    final tPassword = Password("Pass1234");
    final tFirstName = FirstName("John");
    final tLastName = LastName("Doe");

    final tLoginDto = EmailLoginDto(email: tEmail, password: tPassword);
    final tLoginModelDto = EmailLoginModelDto.fromDomain(tLoginDto);
    final tLoginJson = tLoginModelDto.toJson();

    final tLoginResponse = {
      "access_token":
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwiZmlyc3ROYW1lIjoiSm9obiIsImxhc3ROYW1lIjoiRG9lIiwiZW1haWwiOiJ1c2VyQG1haWwuY29tIiwiaWF0IjoxNTE2MjM5MDIyfQ.e0R6TLnfoBXN0Eg2AHz-n3fNI6kzurgt3_BEVU53_ko"
    };
    final tResponse = Response(
      data: tLoginResponse,
      requestOptions: RequestOptions(path: '/'),
    );

    test(
      'should perform a POST request when `loginUserEmail` is called with valid `EmailLoginDto`',
      () async {
        // arrange
        when(
          mockAppHttpClient.post(
            any,
            data: anyNamed('data'),
            queryParameters: anyNamed('queryParameters'),
            options: anyNamed('options'),
            cancelToken: anyNamed('cancelToken'),
            onSendProgress: anyNamed('onSendProgress'),
            onReceiveProgress: anyNamed('onReceiveProgress'),
          ),
        ).thenAnswer((_) async => tResponse);
        // act
        await dataSource.loginUserEmail(tLoginDto);
        // assert
        verify(mockAppHttpClient.post(EndpointUrls.loginUserEmail, data: tLoginJson));
      },
    );
  });
}
