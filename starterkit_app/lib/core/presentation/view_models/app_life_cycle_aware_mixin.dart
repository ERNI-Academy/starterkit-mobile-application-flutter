import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:starterkit_app/core/presentation/view_models/app_life_cycle_aware.dart';
import 'package:starterkit_app/core/presentation/view_models/view_model.dart';

mixin AppLifeCycleAwareMixin on ViewModel implements AppLifeCycleAware {
  late final WidgetsBindingObserver appLifeCycleObserver = _WidgetsBindingObserverImpl(this);

  @override
  Future<void> onAppPaused() => Future.value();

  @override
  Future<void> onAppResumed() => Future.value();

  @override
  Future<void> onAppInactive() => Future.value();

  @override
  Future<void> onAppDetached() => Future.value();
}

class _WidgetsBindingObserverImpl extends WidgetsBindingObserver {
  final AppLifeCycleAware _appLifeCycleAware;

  _WidgetsBindingObserverImpl(this._appLifeCycleAware);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        unawaited(_appLifeCycleAware.onAppPaused());
        break;
      case AppLifecycleState.resumed:
        unawaited(_appLifeCycleAware.onAppResumed());
        break;
      case AppLifecycleState.inactive:
        unawaited(_appLifeCycleAware.onAppInactive());
        break;
      case AppLifecycleState.detached:
        unawaited(_appLifeCycleAware.onAppDetached());
        break;
    }
  }
}
