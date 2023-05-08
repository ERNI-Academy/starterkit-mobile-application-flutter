import 'package:flutter/foundation.dart';

export 'package:flutter/foundation.dart';

abstract class ViewModel extends ChangeNotifier {
  Future<void> onInitialize() => Future.value();

  Future<void> onFirstRender() => Future.value();
}
