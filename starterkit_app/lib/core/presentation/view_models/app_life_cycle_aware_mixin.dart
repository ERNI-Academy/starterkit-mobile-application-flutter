// coverage:ignore-file

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:starterkit_app/core/presentation/view_models/app_life_cycle_aware.dart';

mixin AppLifeCycleAwareMixin implements AppLifeCycleAware {
  @nonVirtual
  late final WidgetsBindingObserver appLifeCycleObserver = _WidgetsBindingObserverImpl(this);

  @override
  Future<void> onAppPaused() async {}

  @override
  Future<void> onAppResumed() async {}

  @override
  Future<void> onAppInactive() async {}

  @override
  Future<void> onAppDetached() async {}

  @override
  Future<void> onAppHidden() async {}
}

class _WidgetsBindingObserverImpl extends WidgetsBindingObserver {
  final AppLifeCycleAware _appLifeCycleAware;

  _WidgetsBindingObserverImpl(this._appLifeCycleAware);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    unawaited(switch (state) {
      AppLifecycleState.paused => _appLifeCycleAware.onAppPaused(),
      AppLifecycleState.resumed => _appLifeCycleAware.onAppResumed(),
      AppLifecycleState.inactive => _appLifeCycleAware.onAppInactive(),
      AppLifecycleState.detached => _appLifeCycleAware.onAppDetached(),
      AppLifecycleState.hidden => _appLifeCycleAware.onAppHidden(),
    });
  }
}
