import 'dart:async';

abstract interface class Initializable {
  Future<void> onInitialize();
}
