import 'package:bid_for_cars/infrastructure/constants/endpoint_urls.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

@module
abstract class ExternalLibraryInjectableModule {
  @lazySingleton
  Dio get dio {
    return Dio(
      BaseOptions(
        baseUrl: EndpointUrls.baseUrl,
        connectTimeout: Duration.millisecondsPerMinute,
        receiveTimeout: Duration.millisecondsPerMinute,
      ),
    );
  }

  @lazySingleton
  DioAdapter get dioAdapter => DioAdapter(dio: dio);

  @lazySingleton
  InternetConnectionChecker get connectionChecker => InternetConnectionChecker();
}
