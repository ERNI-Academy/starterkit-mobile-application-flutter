import 'package:erni_mobile/domain/ui/view_models/view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

mixin AppLifeCycleAwareMixin<T extends Object> on ViewModel<T> implements WidgetsBindingObserver {
  Future<void> onAppPaused() => Future<void>.value();

  Future<void> onAppResumed() => Future<void>.value();

  Future<void> onAppInactive() => Future<void>.value();

  @protected
  @override
  @nonVirtual
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        onAppPaused();
        break;
      case AppLifecycleState.resumed:
        onAppResumed();
        break;
      case AppLifecycleState.inactive:
        onAppInactive();
        break;
      default:
        break;
    }
  }
}
