// coverage:ignore-file

import 'dart:io';

import 'package:erni_mobile/dependency_injection.dart';
import 'package:erni_mobile/domain/services/platform/platform_checker.dart';
import 'package:injectable/injectable.dart';

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
