import 'dart:io';

import 'package:erni_mobile_core/src/dependency_injection/environments.dart';
import 'package:erni_mobile_core/src/dependency_injection/registration.config.dart';
import 'package:erni_mobile_core/src/dependency_injection/service_locator.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: false,
  asExtension: false,
)
Future<void> internalRegistration({
  GetIt Function(GetIt get, {String? environment, EnvironmentFilter? environmentFilter})? registration,
  Future<GetIt> Function(GetIt get, {String? environment, EnvironmentFilter? environmentFilter})? asyncRegistration,
  bool isTest = false,
}) async {
  final environments = <String>{};

  if (kIsWeb) {
    environments.add(platformWeb.name);
  } else if (Platform.isAndroid || Platform.isIOS) {
    environments.add(platformMobile.name);
  } else if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    environments.add(platformDesktop.name);
  } else {
    throw UnsupportedError('Current platform not supported');
  }

  if (isTest) {
    environments.add(test.name);
  } else {
    environments.add(prod.name);
  }

  if (kReleaseMode) {
    environments.add(release.name);
  } else if (kDebugMode) {
    environments.add(debug.name);
  }

  final environmentFilter = NoEnvOrContainsAny(environments);
  await $initGetIt(ServiceLocator.instance, environmentFilter: environmentFilter);
  registration?.call(ServiceLocator.instance, environmentFilter: environmentFilter);
  await asyncRegistration?.call(ServiceLocator.instance, environmentFilter: environmentFilter);
}
