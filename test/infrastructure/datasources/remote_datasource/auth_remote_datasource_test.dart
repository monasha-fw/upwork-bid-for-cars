import 'dart:convert';

import 'package:bid_for_cars/core/dtos/auth/email_login_dto.dart';
import 'package:bid_for_cars/core/errors/failures.dart';
import 'package:bid_for_cars/core/value_objects/value_objects.dart';
import 'package:bid_for_cars/infrastructure/constants/endpoint_urls.dart';
import 'package:bid_for_cars/infrastructure/datasources/remote_datasource/auth_remote_datasource.dart';
import 'package:bid_for_cars/infrastructure/dtos/auth/email_login_model_dto.dart';
import 'package:bid_for_cars/infrastructure/models/auth/auth_tokens_response_model.dart';
import 'package:bid_for_cars/infrastructure/network/http_client.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixture_reader.dart';
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
    final dto = EmailLoginDto(
      email: EmailAddress("person@mail.co"),
      password: Password("Pass12345"),
    );
    final dtoJson = EmailLoginModelDto.fromDomain(dto).toJson();

    final tokensJson = jsonDecode(fixture(Fixture.tokens));
    final invalidTokensJSONs = [
      jsonDecode(fixture(Fixture.tokensInvalid, version: 1)),
      jsonDecode(fixture(Fixture.tokensInvalid, version: 2)),
    ];
    final tokens = AuthTokensResponseModel.fromJson(tokensJson).toAuthTokens();

    test(
      'should send a POST request when `loginUserEmail` is called',
      () async {
        // arrange
        when(mockAppHttpClient.post(any, data: anyNamed('data')))
            .thenAnswer((_) async => Response(requestOptions: RequestOptions(), data: tokensJson));
        // act
        await dataSource.loginUserEmail(dto);
        // assert
        verify(mockAppHttpClient.post(EndpointUrls.loginUserEmail, data: dtoJson));
      },
    );

    test(
      'should return `AuthTokens` when a valid `EmailLoginDto` is passed',
      () async {
        // arrange
        when(mockAppHttpClient.post(any, data: anyNamed('data')))
            .thenAnswer((_) async => Response(requestOptions: RequestOptions(), data: tokensJson));
        // act
        final result = await dataSource.loginUserEmail(dto);
        // assert
        expect(result, Right(tokens));
      },
    );

    group('should return a `ValueFailure` when the passed `EmailLoginDto` has invalid values', () {
      const invalidPasswordString = "inv";
      const invalidEmailString = "<some invalid email>";

      test(
        'When `EmailLoginDto` has an invalid email',
        () async {
          // arrange
          // act
          final result = await dataSource.loginUserEmail(dto.copyWith(
            email: EmailAddress(invalidEmailString),
          ));
          // assert
          expect(result, const Left(Failure.unableToProcess(invalidEmailString)));
        },
      );
      test(
        'When `EmailLoginDto` has an invalid password',
        () async {
          // arrange
          // act
          final result = await dataSource.loginUserEmail(dto.copyWith(
            password: Password(invalidPasswordString),
          ));
          // assert
          expect(result, const Left(Failure.unableToProcess(invalidPasswordString)));
        },
      );

      test(
        'When `EmailLoginDto` has both invalid email and invalid password',
        () async {
          // arrange
          // act
          final result = await dataSource.loginUserEmail(dto.copyWith(
            email: EmailAddress(invalidEmailString),
            password: Password(invalidPasswordString),
          ));
          // assert
          expect(result, const Left(Failure.unableToProcess(invalidEmailString)));
        },
      );
    });

    group('Should return an failure when the server sends an [InvalidResponse]', () {
      test(
        'when the Response is not a valid JSON',
        () async {
          // arrange
          when(mockAppHttpClient.post(any, data: anyNamed('data'))).thenAnswer((_) async =>
              Response(requestOptions: RequestOptions(), data: invalidTokensJSONs.elementAt(0)));
          // act
          final result = await dataSource.loginUserEmail(dto);
          // assert
          expect(
            result,
            const Left(
              Failure.unableToProcess(
                "type 'String' is not a subtype of type 'Map<String, dynamic>'",
              ),
            ),
          );
        },
      );

      test(
        'when the [accessToken] is null',
        () async {
          // arrange
          when(mockAppHttpClient.post(any, data: anyNamed('data'))).thenAnswer((_) async =>
              Response(requestOptions: RequestOptions(), data: invalidTokensJSONs.elementAt(1)));
          // act
          final result = await dataSource.loginUserEmail(dto);
          // assert
          expect(
            result,
            const Left(
              Failure.unableToProcess(
                "type 'Null' is not a subtype of type 'String' in type cast",
              ),
            ),
          );
        },
      );
    });
  });
}
