import 'package:erni_mobile/domain/ui/view_models/view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

mixin AppLifeCycleAwareMixin<T extends Object> on ViewModel<T> {
  late final WidgetsBindingObserver appLifeCylceObserver = _WidgetsBindingObserverImpl(this);

  Future<void> onAppPaused() async {}

  Future<void> onAppResumed() async {}

  Future<void> onAppInactive() async {}
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
