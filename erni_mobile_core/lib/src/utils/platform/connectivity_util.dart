import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

abstract class ConnectivityUtil {
  void ensureConnected();

  void dispose();
}

@Singleton(as: ConnectivityUtil)
@preResolve
@prod
class ConnectivityUtilImpl implements ConnectivityUtil {
  ConnectivityUtilImpl(this._currentState, this._connectivityStreamCtrl) {
    _connectivitySubscription = _connectivityStreamCtrl.stream.listen((event) {
      _currentState = event;
    });
  }

  final StreamController<ConnectivityResult> _connectivityStreamCtrl;
  late final StreamSubscription<void> _connectivitySubscription;
  ConnectivityResult _currentState;

  @factoryMethod
  static Future<ConnectivityUtilImpl> create() async {
    final connectivity = Connectivity();
    final completer = Completer<ConnectivityResult>();
    // ignore: close_sinks
    final StreamController<ConnectivityResult> streamCtrl = StreamController.broadcast();
    connectivity.onConnectivityChanged.listen((event) {
      if (!completer.isCompleted) {
        completer.complete(event);
      }
      streamCtrl.add(event);
    });
    final state =
        await completer.future.timeout(const Duration(milliseconds: 500), onTimeout: connectivity.checkConnectivity);

    return ConnectivityUtilImpl(state, streamCtrl);
  }

  @override
  void ensureConnected() {
    if (_currentState == ConnectivityResult.none) {
      throw const NoInternetException();
    }
  }

  @disposeMethod
  @override
  void dispose() {
    _connectivityStreamCtrl.close();
    _connectivitySubscription.cancel();
  }
}

@Singleton(as: ConnectivityUtil)
@test
class TestConnecivityUtilImpl implements ConnectivityUtil {
  @override
  void ensureConnected() => Future<void>.value();

  @disposeMethod
  @override
  void dispose() => Future<void>.value();
}

class NoInternetException implements Exception {
  const NoInternetException();
}
