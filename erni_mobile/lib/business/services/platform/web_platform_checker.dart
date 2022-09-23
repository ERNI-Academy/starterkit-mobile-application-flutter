// coverage:ignore-file

import 'package:erni_mobile/dependency_injection.dart';
import 'package:erni_mobile/domain/services/platform/platform_checker.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PlatformChecker)
@platformWeb
class WebPlatformCheckerImpl extends PlatformChecker {
  @override
  bool get isAndroid => false;

  @override
  bool get isIOS => false;

  @override
  bool get isWindows => false;

  @override
  bool get isLinux => false;

  @override
  bool get isMacOS => false;
}
