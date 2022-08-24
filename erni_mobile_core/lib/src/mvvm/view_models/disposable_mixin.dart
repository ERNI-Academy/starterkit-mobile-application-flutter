import 'package:flutter/foundation.dart';

mixin DisposableMixin on ChangeNotifier {
  final ValueNotifier<bool> isDisposed = ValueNotifier(false);

  @override
  @mustCallSuper
  void dispose() {
    isDisposed.value = true;
    super.dispose();
  }
}
