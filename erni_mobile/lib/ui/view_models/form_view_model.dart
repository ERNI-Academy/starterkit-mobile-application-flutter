import 'package:erni_mobile/ui/view_models/view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:simple_command/commands.dart';

abstract class FormViewModel<T extends Object> extends ViewModel<T> {
  final ValueNotifier<String> errorMessage = ValueNotifier('');

  late final AsyncRelayCommand<void> submitCommand = AsyncRelayCommand.withoutParam(onSubmit);

  @protected
  Future<void> onSubmit();
}
