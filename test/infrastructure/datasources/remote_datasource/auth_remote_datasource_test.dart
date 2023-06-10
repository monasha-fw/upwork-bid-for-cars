import 'package:bid_for_cars/core/dtos/auth/email_login_dto.dart';
import 'package:bid_for_cars/infrastructure/constants/endpoint_urls.dart';
import 'package:bid_for_cars/infrastructure/datasources/remote_datasource/auth_remote_datasource.dart';
import 'package:bid_for_cars/infrastructure/network/http_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAppHttpClient extends Mock implements AppHttpClient {}

class MockEmailLoginDto extends Mock implements EmailLoginDto {}

class MockResponse extends Mock implements Response {}

void main() {
  late AuthRemoteDatasourceImpl dataSource;
  late MockAppHttpClient mockAppHttpClient;

  setUp(() {
    mockAppHttpClient = MockAppHttpClient();
    dataSource = AuthRemoteDatasourceImpl(mockAppHttpClient);
  });

  group('loginUserEmail', () {
    final mockResponse = MockResponse();
    final mockDto = MockEmailLoginDto();

    test(
      'should perform a POST request when `loginUserEmail` is called with valid `EmailLoginDto`',
      () async {
        // arrange
        when(
          () => mockAppHttpClient.post(
            any(),
            data: captureAny(),
            queryParameters: captureAny(),
            options: captureAny(),
            cancelToken: captureAny(),
            onSendProgress: captureAny(),
            onReceiveProgress: captureAny(),
          ),
        ).thenAnswer((_) async => mockResponse);
        // act
        await dataSource.loginUserEmail(mockDto);
        // assert
        verify(() => mockAppHttpClient.post(EndpointUrls.loginUserEmail, data: captureAny()));
      },
    );
  });
}
