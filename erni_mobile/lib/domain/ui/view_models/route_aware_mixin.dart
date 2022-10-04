import 'package:erni_mobile/domain/ui/view_models/view_model.dart';
import 'package:flutter/widgets.dart';

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
