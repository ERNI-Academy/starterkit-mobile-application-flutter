import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

abstract interface class ConnectivityService {
  Future<bool> isConnected();
}

@LazySingleton(as: ConnectivityService)
class ConnectivityServiceImpl implements ConnectivityService {
  final Connectivity _connectivity;

  const ConnectivityServiceImpl(this._connectivity);

  @override
  Future<bool> isConnected() async {
    final ConnectivityResult status = await _connectivity.checkConnectivity();
    final bool isConnected = _isConnected(status);

    return isConnected;
  }

  static bool _isConnected(ConnectivityResult status) {
    return status == ConnectivityResult.wifi ||
        status == ConnectivityResult.mobile ||
        status == ConnectivityResult.ethernet;
  }
}
