import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

abstract class ConfigurationChecker {
  bool get isRelease;

  bool get isDebug;

  bool get isProfile;
}

@LazySingleton(as: ConfigurationChecker)
class ConfigurationCheckerImpl implements ConfigurationChecker {
  @override
  bool get isDebug => kDebugMode;

  @override
  bool get isRelease => kReleaseMode;

  @override
  bool get isProfile => kProfileMode;
}
