import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ConnectivityService {
  final Connectivity _connectivity;

  ConnectivityService(this._connectivity);

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
