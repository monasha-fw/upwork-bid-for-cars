import 'dart:io';

import 'package:bid_for_cars/infrastructure/network/http_client.dart';
import 'package:bid_for_cars/infrastructure/network/i_network_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class MockINetworkInfo extends Mock implements INetworkInfo {}

class MockDioAdapter extends Mock implements DioAdapter {}

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
        'should throws a `SocketException("No working internet connections found")` when internet is not connected',
        () async {
          // arrange
          when(() => mockINetworkInfo.isConnected).thenAnswer((_) async => false);
          // act
          final call = httpClient.get;
          // assert
          expect(
            () => call(('/')),
            throwsA(const SocketException("No working internet connections found")),
          );
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
          when(() => mockINetworkInfo.isConnected).thenAnswer((_) async => true);
          when(() => mockDio.get(any())).thenAnswer((_) async => response);
          // act
          final result = await mockDio.get("/ping");
          // assert
          expect(result, equals(response));
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
          when(() => mockINetworkInfo.isConnected).thenAnswer((_) async => false);
          // act
          final call = httpClient.post;
          // assert
          expect(
            () => call(('/')),
            throwsA(const SocketException("No working internet connections found")),
          );
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
          when(() => mockINetworkInfo.isConnected).thenAnswer((_) async => true);
          when(() => mockDio.post(any(), data: any())).thenAnswer((_) async => response);
          // act
          final result = await mockDio.post("/ping", data: "1");
          // assert
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
          when(() => mockINetworkInfo.isConnected).thenAnswer((_) async => false);
          // act
          final call = httpClient.delete;
          // assert
          expect(
            () => call(('/')),
            throwsA(const SocketException("No working internet connections found")),
          );
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
          when(() => mockINetworkInfo.isConnected).thenAnswer((_) async => true);
          when(() => mockDio.delete(any(), data: any())).thenAnswer((_) async => response);
          // act
          final result = await mockDio.delete("/ping", data: "1");
          // assert
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
          when(() => mockINetworkInfo.isConnected).thenAnswer((_) async => false);
          // act
          final call = httpClient.patch;
          // assert
          expect(
            () => call(('/')),
            throwsA(const SocketException("No working internet connections found")),
          );
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
          when(() => mockINetworkInfo.isConnected).thenAnswer((_) async => true);
          when(() => mockDio.patch(any(), data: any())).thenAnswer((_) async => response);
          // act
          final result = await mockDio.patch("/ping", data: "1");
          // assert
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
          when(() => mockINetworkInfo.isConnected).thenAnswer((_) async => false);
          // act
          final call = httpClient.put;
          // assert
          expect(
            () => call(('/')),
            throwsA(const SocketException("No working internet connections found")),
          );
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
          when(() => mockINetworkInfo.isConnected).thenAnswer((_) async => true);
          when(() => mockDio.put(any(), data: any())).thenAnswer((_) async => response);
          // act
          final result = await mockDio.put("/ping", data: "1");
          // assert
          expect(result, equals(response));
        },
      );
    });
  });
}
