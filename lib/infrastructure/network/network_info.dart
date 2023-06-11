import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class INetworkInfo {
  Future<bool> get isConnected;
}

@Singleton(as: INetworkInfo)
class NetworkInfoImpl implements INetworkInfo {
  final InternetConnectionChecker connection;

  const NetworkInfoImpl(this.connection);

  @override
  Future<bool> get isConnected => connection.hasConnection;
}
