import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

abstract class UiUtil {
  void addPostFrameCallback(VoidCallback callback);
}

@LazySingleton(as: UiUtil)
class UiUtilImpl implements UiUtil {
  @override
  void addPostFrameCallback(VoidCallback callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) => callback());
  }
}
