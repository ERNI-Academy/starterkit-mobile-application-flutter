import 'package:erni_mobile/ui/inputs/command.dart';
import 'package:flutter/foundation.dart';

abstract class AsyncCommand<T extends Object> extends Command<T> {
  ValueNotifier<bool> isExecuting = ValueNotifier(false);

  @override
  Future<void> call([T? parameter]);
}
