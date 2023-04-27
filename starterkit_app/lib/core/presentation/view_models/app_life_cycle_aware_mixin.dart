import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:starterkit_app/core/presentation/view_models/view_model.dart';

mixin AppLifeCycleAwareMixin on ViewModel {
  late final WidgetsBindingObserver appLifeCycleObserver = _WidgetsBindingObserverImpl(this);

  Future<void> onAppPaused() => Future.value();

  Future<void> onAppResumed() => Future.value();

  Future<void> onAppInactive() => Future.value();
}

class _WidgetsBindingObserverImpl extends WidgetsBindingObserver {
  final AppLifeCycleAwareMixin _delegate;

  _WidgetsBindingObserverImpl(this._delegate);

  @protected
  @override
  @nonVirtual
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        unawaited(_delegate.onAppPaused());
        break;
      case AppLifecycleState.resumed:
        unawaited(_delegate.onAppResumed());
        break;
      case AppLifecycleState.inactive:
        unawaited(_delegate.onAppInactive());
        break;
      default:
        break;
    }
  }
}
