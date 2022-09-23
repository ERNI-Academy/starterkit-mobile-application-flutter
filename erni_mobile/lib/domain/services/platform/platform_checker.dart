import 'package:flutter/foundation.dart';

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
