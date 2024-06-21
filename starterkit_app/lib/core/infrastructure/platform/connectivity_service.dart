import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ConnectivityService {
  final Connectivity _connectivity;

  ConnectivityService(this._connectivity);

  Future<bool> isConnected() async {
    final List<ConnectivityResult> statuses = await _connectivity.checkConnectivity();
    final bool isConnected = _isConnected(statuses);

    return isConnected;
  }

  static bool _isConnected(List<ConnectivityResult> statuses) {
    return statuses.contains(ConnectivityResult.wifi) ||
        statuses.contains(ConnectivityResult.mobile) ||
        statuses.contains(ConnectivityResult.ethernet);
  }
}
