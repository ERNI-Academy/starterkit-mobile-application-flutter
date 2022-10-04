import 'package:erni_mobile/domain/ui/view_models/view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

mixin AppLifeCycleAwareMixin on ViewModel {
  late final WidgetsBindingObserver appLifeCycleObserver = _WidgetsBindingObserverImpl(this);

  Future<void> onAppPaused() => Future.value();

  Future<void> onAppResumed() => Future.value();

  Future<void> onAppInactive() => Future.value();
}

class _WidgetsBindingObserverImpl extends WidgetsBindingObserver {
  _WidgetsBindingObserverImpl(this._delegate);

  final AppLifeCycleAwareMixin _delegate;

  @protected
  @override
  @nonVirtual
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        _delegate.onAppPaused();
        break;
      case AppLifecycleState.resumed:
        _delegate.onAppResumed();
        break;
      case AppLifecycleState.inactive:
        _delegate.onAppInactive();
        break;
      default:
        break;
    }
  }
}
