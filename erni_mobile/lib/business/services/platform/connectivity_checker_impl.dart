import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:erni_mobile/domain/services/platform/connectivity_checker.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: ConnectivityChecker)
@preResolve
class ConnectivityCheckerImpl implements ConnectivityChecker {
  ConnectivityCheckerImpl(this._currentState, this._connectivityStreamCtrl) {
    _connectivitySubscription = _connectivityStreamCtrl.stream.listen((event) {
      _currentState = event;
    });
  }

  final StreamController<ConnectivityResult> _connectivityStreamCtrl;
  late final StreamSubscription<void> _connectivitySubscription;
  ConnectivityResult _currentState;

  @factoryMethod
  static Future<ConnectivityCheckerImpl> create() async {
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

    return ConnectivityCheckerImpl(state, streamCtrl);
  }

  @override
  bool isConnected() => _currentState != ConnectivityResult.none;

  @disposeMethod
  @override
  void dispose() {
    _connectivityStreamCtrl.close();
    _connectivitySubscription.cancel();
  }
}
