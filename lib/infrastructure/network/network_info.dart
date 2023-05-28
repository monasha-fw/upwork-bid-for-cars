import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'i_network_info.dart';

@Singleton(as: INetworkInfo)
class NetworkInfoImpl implements INetworkInfo {
  final InternetConnectionChecker connection;

  NetworkInfoImpl(this.connection);

  @override
  Future<bool> get isConnected => connection.hasConnection;
}
