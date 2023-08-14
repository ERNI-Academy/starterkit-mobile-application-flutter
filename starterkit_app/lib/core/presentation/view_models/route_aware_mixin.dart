import 'package:flutter/widgets.dart';
import 'package:starterkit_app/core/presentation/view_models/view_model.dart';

mixin RouteAwareMixin on ViewModel implements RouteAware {
  @override
  Future<void> didPop() => Future.value();

  @override
  Future<void> didPush() => Future.value();

  @override
  Future<void> didPushNext() => Future.value();

  @override
  Future<void> didPopNext() => Future.value();
}
