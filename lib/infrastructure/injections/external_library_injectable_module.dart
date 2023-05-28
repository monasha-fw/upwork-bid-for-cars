import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

@module
abstract class ExternalLibraryInjectableModule {
  @lazySingleton
  Dio get dio => Dio();

  @lazySingleton
  DioAdapter get dioAdapter => DioAdapter(dio: dio);

  @lazySingleton
  InternetConnectionChecker get connectionChecker => InternetConnectionChecker();
}
