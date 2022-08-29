import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

mixin AppLifeCycleAwareMixin {
  Future<void> onAppPaused() => Future.value();

  Future<void> onAppResumed() => Future.value();

  Future<void> onAppInactive() => Future.value();
}

class WidgetsBindingObserverWrapper with WidgetsBindingObserver {
  WidgetsBindingObserverWrapper(this._appLifeCycleAware);

  final AppLifeCycleAwareMixin _appLifeCycleAware;

  @override
  @nonVirtual
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        _appLifeCycleAware.onAppPaused();
        break;
      case AppLifecycleState.resumed:
        _appLifeCycleAware.onAppResumed();
        break;
      case AppLifecycleState.inactive:
        _appLifeCycleAware.onAppInactive();
        break;
      default:
        break;
    }
  }
}
