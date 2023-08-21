import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:starterkit_app/core/presentation/view_models/app_life_cycle_aware.dart';
import 'package:starterkit_app/core/presentation/view_models/view_model.dart';

mixin AppLifeCycleAwareMixin on ViewModel implements AppLifeCycleAware {
  WidgetsBindingObserver? _appLifeCycleObserver;

  WidgetsBindingObserver get appLifeCycleObserver => _appLifeCycleObserver ?? _WidgetsBindingObserverImpl(this);

  @override
  Future<void> onAppPaused() => Future.value();

  @override
  Future<void> onAppResumed() => Future.value();

  @override
  Future<void> onAppInactive() => Future.value();

  @override
  Future<void> onAppDetached() => Future.value();

  @override
  Future<void> onAppHidden() => Future.value();
}

class _WidgetsBindingObserverImpl extends WidgetsBindingObserver {
  final AppLifeCycleAware _appLifeCycleAware;

  _WidgetsBindingObserverImpl(this._appLifeCycleAware);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        unawaited(_appLifeCycleAware.onAppPaused());

      case AppLifecycleState.resumed:
        unawaited(_appLifeCycleAware.onAppResumed());

      case AppLifecycleState.inactive:
        unawaited(_appLifeCycleAware.onAppInactive());

      case AppLifecycleState.detached:
        unawaited(_appLifeCycleAware.onAppDetached());

      case AppLifecycleState.hidden:
        unawaited(_appLifeCycleAware.onAppHidden());
    }
  }
}
