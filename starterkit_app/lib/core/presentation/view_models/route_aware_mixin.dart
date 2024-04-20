// coverage:ignore-file

import 'package:flutter/widgets.dart';

mixin RouteAwareMixin implements RouteAware {
  @override
  Future<void> didPop() => Future<void>.value();

  @override
  Future<void> didPush() => Future<void>.value();

  @override
  Future<void> didPushNext() => Future<void>.value();

  @override
  Future<void> didPopNext() => Future<void>.value();
}
