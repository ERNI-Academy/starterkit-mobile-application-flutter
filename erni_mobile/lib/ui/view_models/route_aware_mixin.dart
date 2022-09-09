import 'package:flutter/widgets.dart';

mixin RouteAwareMixin implements RouteAware {
  @override
  Future<void> didPop() => Future.value();

  @override
  Future<void> didPush() => Future.value();

  @override
  Future<void> didPushNext() => Future.value();

  @override
  Future<void> didPopNext() => Future.value();
}
