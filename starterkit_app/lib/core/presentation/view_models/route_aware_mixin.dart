// coverage:ignore-file

import 'package:flutter/widgets.dart';
import 'package:starterkit_app/core/presentation/view_models/view_model.dart';

mixin RouteAwareMixin on ViewModel implements RouteAware {
  @override
  Future<void> didPop() => Future<void>.value();

  @override
  Future<void> didPush() => Future<void>.value();

  @override
  Future<void> didPushNext() => Future<void>.value();

  @override
  Future<void> didPopNext() => Future<void>.value();
}
