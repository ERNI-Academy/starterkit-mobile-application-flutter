import 'package:flutter/widgets.dart';

mixin RouteAwareMixin {
  Future<void> didPop() => Future.value();

  Future<void> didPush() => Future.value();

  Future<void> didPushNext() => Future.value();

  Future<void> didPopNext() => Future.value();
}

class RouteAwareWrapper implements RouteAware {
  RouteAwareWrapper(this._routeAwareMixin);

  final RouteAwareMixin _routeAwareMixin;

  @override
  void didPop() => _routeAwareMixin.didPop();

  @override
  void didPush() => _routeAwareMixin.didPush();

  @override
  void didPushNext() => _routeAwareMixin.didPushNext();

  @override
  void didPopNext() => _routeAwareMixin.didPopNext();
}
