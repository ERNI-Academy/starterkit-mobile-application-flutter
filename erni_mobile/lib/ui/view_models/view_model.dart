import 'package:erni_mobile/domain/services/ui/navigation/navigation_service.dart';
import 'package:erni_mobile/ui/view_models/disposable_mixin.dart';
import 'package:flutter/widgets.dart';

abstract class ViewModel<TParameter extends Object> extends ChangeNotifier with DisposableMixin {
  Future<void> onInitialize([TParameter? parameter, Queries queries = const {}]) => Future.value();

  Future<bool> onWillPop() => Future.value(true);
}
