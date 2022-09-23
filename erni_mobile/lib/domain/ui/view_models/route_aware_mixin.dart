import 'package:erni_mobile/domain/ui/view_models/view_model.dart';
import 'package:flutter/widgets.dart';

mixin RouteAwareMixin<T extends Object> on ViewModel<T> implements RouteAware {
  @override
  Future<void> didPop() async {}

  @override
  Future<void> didPush() async {}

  @override
  Future<void> didPushNext() async {}

  @override
  Future<void> didPopNext() async {}
}
