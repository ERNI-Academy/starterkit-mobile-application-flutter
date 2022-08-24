import 'dart:io';

import 'package:erni_mobile_core/src/dependency_injection/environments.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

abstract class PlatformChecker {
  bool get isAndroid;

  bool get isIOS;

  bool get isWindows;

  bool get isMacOS;

  bool get isLinux;

  bool get isWeb => kIsWeb;

  bool get isDesktop => isWindows || isMacOS || isLinux;

  bool get isMobile => isAndroid || isIOS;
}

@LazySingleton(as: PlatformChecker)
@platformMobile
@platformDesktop
class IOPlatformCheckerImpl extends PlatformChecker {
  @override
  bool get isAndroid => Platform.isAndroid;

  @override
  bool get isIOS => Platform.isIOS;

  @override
  bool get isWindows => Platform.isWindows;

  @override
  bool get isLinux => Platform.isLinux;

  @override
  bool get isMacOS => Platform.isMacOS;
}

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
