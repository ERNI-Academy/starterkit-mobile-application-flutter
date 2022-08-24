import 'package:flutter/foundation.dart' as foundation;
import 'package:injectable/injectable.dart';

abstract class FutureUtils {
  Future<void> delayFor(int milliseconds);

  Future<T> compute<P, T>(Future<T> Function(P message) callback, P message, {String? debugLabel});
}

@LazySingleton(as: FutureUtils)
class FutureUtilsImpl implements FutureUtils {
  @override
  Future<void> delayFor(int milliseconds) => Future.delayed(Duration(milliseconds: milliseconds));

  @override
  Future<T> compute<P, T>(Future<T> Function(P message) callback, P message, {String? debugLabel}) {
    return foundation.compute(callback, message, debugLabel: debugLabel);
  }
}
