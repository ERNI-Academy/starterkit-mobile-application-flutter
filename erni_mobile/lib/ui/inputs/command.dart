import 'package:flutter/foundation.dart';

abstract class Command<T extends Object> {
  final ValueNotifier<bool> canExecute = ValueNotifier(true);

  void call([T? parameter]);
}
