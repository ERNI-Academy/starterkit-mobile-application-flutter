import 'package:erni_mobile/ui/inputs/async_relay_command.dart';
import 'package:erni_mobile/ui/view_models/view_model.dart';
import 'package:flutter/foundation.dart';

abstract class FormViewModel<T extends Object> extends ViewModel<T> {
  final ValueNotifier<String> errorMessage = ValueNotifier('');

  late final AsyncRelayCommand submitCommand = AsyncRelayCommand.withoutParam(onSubmit);

  @protected
  Future<void> onSubmit();
}
