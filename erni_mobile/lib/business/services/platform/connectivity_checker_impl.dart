import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:erni_mobile/domain/services/platform/connectivity_checker.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ConnectivityChecker)
class ConnectivityCheckerImpl implements ConnectivityChecker {
  ConnectivityCheckerImpl(this._connectivity);

  final Connectivity _connectivity;
  late final StreamSubscription<void> _connectivitySubscription;
  ConnectivityResult _currentState = ConnectivityResult.none;

  @override
  Future<void> initialize() async {
    final completer = Completer<void>();

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((event) {
      _currentState = event;
      if (!completer.isCompleted) {
        completer.complete();
      }
    });

    await completer.future.timeout(
      const Duration(milliseconds: 500),
      onTimeout: () async => _currentState = await _connectivity.checkConnectivity(),
    );
  }

  @override
  bool isConnected() => _currentState != ConnectivityResult.none;

  @disposeMethod
  @override
  void dispose() {
    _connectivitySubscription.cancel();
  }
}
