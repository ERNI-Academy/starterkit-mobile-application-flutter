import 'package:erni_mobile_blueprint_core/mvvm.dart';
import 'package:flutter/foundation.dart';

abstract class FormViewModel<T extends Object> extends ViewModel<T> {
  final ValueNotifier<String> errorMessage = ValueNotifier('');

  late final AsyncRelayCommand submitCommand = AsyncRelayCommand.withoutParam(onSubmit);

  @protected
  Future<void> onSubmit();
}
