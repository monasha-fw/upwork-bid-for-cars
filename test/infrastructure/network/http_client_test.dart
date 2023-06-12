import 'dart:io';

import 'package:bid_for_cars/infrastructure/network/http_client.dart';
import 'package:bid_for_cars/infrastructure/network/network_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'http_client_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<Dio>(),
  MockSpec<INetworkInfo>(),
  MockSpec<DioAdapter>(),
])
void main() {
  late AppHttpClient httpClient;
  late MockDio mockDio;
  late MockINetworkInfo mockINetworkInfo;
  late MockDioAdapter mockDioAdapter;

  setUp(() {
    mockDio = MockDio();
    mockDioAdapter = MockDioAdapter();
    mockINetworkInfo = MockINetworkInfo();
    httpClient = AppHttpClient(mockDio, mockINetworkInfo, mockDioAdapter);
  });

  group('GET requests', () {
    group('No Internet', () {
      test(
        'should throws a `SocketException` when internet is not connected',
        () async {
          // arrange
          when(mockINetworkInfo.isConnected).thenAnswer((_) async => false);
          // act
          final call = httpClient.get;
          // assert
          expect(() => call('/'), throwsA(isA<SocketException>()));
          verifyNever(mockDio.get('/'));
        },
      );
    });

    group('Has Internet', () {
      test(
        'should return a Response when called',
        () async {
          // arrange
          final response = Response(
            data: "pong",
            statusCode: 200,
            requestOptions: RequestOptions(path: '/ping', responseType: ResponseType.json),
          );
          when(mockINetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockDio.get("/ping")).thenAnswer((_) async => response);
          // act
          final result = await mockDio.get("/ping");
          // assert
          expect(result, equals(response));
          verify(mockDio.get('/ping'));
        },
      );
    });
  });

  group('POST requests', () {
    group('No Internet', () {
      test(
        'should throws a `SocketException("No working internet connections found")` when internet is not connected',
        () async {
          // arrange
          when(mockINetworkInfo.isConnected).thenAnswer((_) async => false);
          // act
          final call = httpClient.post;
          // assert
          expect(() => call(('/')), throwsA(isA<SocketException>()));
          verifyNever(mockDio.post('/'));
        },
      );
    });

    group('Has Internet', () {
      test(
        'should return a Response when called',
        () async {
          // arrange
          final response = Response(
            data: "pong 1",
            statusCode: 200,
            requestOptions: RequestOptions(path: '/ping', responseType: ResponseType.json),
          );
          when(mockINetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockDio.post("/ping", data: anyNamed('data'))).thenAnswer((_) async => response);
          // act
          final result = await mockDio.post("/ping", data: 'data');
          // assert
          verify(mockDio.post('/ping', data: 'data'));
          expect(result, equals(response));
        },
      );
    });
  });

  group('DELETE requests', () {
    group('No Internet', () {
      test(
        'should throws a `SocketException("No working internet connections found")` when internet is not connected',
        () async {
          // arrange
          when(mockINetworkInfo.isConnected).thenAnswer((_) async => false);
          // act
          final call = httpClient.delete;
          // assert
          expect(() => call(('/')), throwsA(isA<SocketException>()));
          verifyNever(mockDio.delete('/'));
        },
      );
    });

    group('Has Internet', () {
      test(
        'should return a Response when called',
        () async {
          // arrange
          final response = Response(
            statusCode: 204,
            requestOptions: RequestOptions(path: '/ping', responseType: ResponseType.json),
          );
          when(mockINetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockDio.delete("/ping", data: anyNamed('data'))).thenAnswer((_) async => response);
          // act
          final result = await mockDio.delete("/ping", data: 'data');
          // assert
          verify(mockDio.delete('/ping', data: 'data'));
          expect(result, equals(response));
        },
      );
    });
  });

  group('PATCH requests', () {
    group('No Internet', () {
      test(
        'should throws a `SocketException("No working internet connections found")` when internet is not connected',
        () async {
          // arrange
          when(mockINetworkInfo.isConnected).thenAnswer((_) async => false);
          // act
          final call = httpClient.patch;
          // assert
          expect(() => call(('/')), throwsA(isA<SocketException>()));
          verifyNever(mockDio.patch('/'));
        },
      );
    });

    group('Has Internet', () {
      test(
        'should return a Response when called',
        () async {
          // arrange
          final response = Response(
            statusCode: 204,
            requestOptions: RequestOptions(path: '/ping', responseType: ResponseType.json),
          );
          when(mockINetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockDio.patch("/ping", data: anyNamed('data'))).thenAnswer((_) async => response);
          // act
          final result = await mockDio.patch("/ping", data: 'data');
          // assert
          verify(mockDio.patch('/ping', data: 'data'));
          expect(result, equals(response));
        },
      );
    });
  });

  group('PUT requests', () {
    group('No Internet', () {
      test(
        'should throws a `SocketException("No working internet connections found")` when internet is not connected',
        () async {
          // arrange
          when(mockINetworkInfo.isConnected).thenAnswer((_) async => false);
          // act
          // final call = httpClient.put;
          // assert
          expect(() => httpClient.put('/'), throwsA(isA<SocketException>()));
          verifyNever(mockDio.put('/'));
        },
      );
    });

    group('Has Internet', () {
      test(
        'should return a Response when called',
        () async {
          // arrange
          final response = Response(
            statusCode: 204,
            requestOptions: RequestOptions(path: '/ping', responseType: ResponseType.json),
          );
          when(mockINetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockDio.put("/ping", data: anyNamed('data'))).thenAnswer((_) async => response);
          // act
          final result = await mockDio.put("/ping", data: 'data');
          // assert
          expect(result, equals(response));
        },
      );
    });
  });
}
