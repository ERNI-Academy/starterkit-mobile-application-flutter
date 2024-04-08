import 'dart:async';

import 'package:meta/meta.dart';

@optionalTypeArgs
abstract interface class Initializable<T> {
  Future<void> onInitialize(T parameter);
}
