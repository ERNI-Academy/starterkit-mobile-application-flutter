import 'dart:io';

import 'package:drift/drift.dart';
import 'package:erni_mobile/data/web/apis/api.dart';
import 'package:erni_mobile/dependency_injection.config.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

@InjectableInit(
  initializerName: r'$register',
  preferRelativeImports: false,
  asExtension: false,
)
Future<void> registerDependencies({bool isTest = false}) async {
  await ServiceLocator.registerDependencies(isTest: isTest, asyncRegistration: $register);

  driftRuntimeOptions.dontWarnAboutMultipleDatabases = isTest;

  // We register `ApiEndpoints.baseUrl` here since its value is determined during runtime.
  ServiceLocator.instance.registerSingleton(ApiEndpoints.baseUrl, instanceName: apiBaseUrl.name);
}

abstract class ServiceLocator {
  static final GetIt instance = GetIt.instance..allowReassignment = true;

  static Future<void> registerDependencies({
    GetIt Function(GetIt get, {String? environment, EnvironmentFilter? environmentFilter})? registration,
    Future<GetIt> Function(GetIt get, {String? environment, EnvironmentFilter? environmentFilter})? asyncRegistration,
    bool isTest = false,
  }) {
    return _internalRegistration(isTest: isTest, registration: registration, asyncRegistration: asyncRegistration);
  }
}

Future<void> _internalRegistration({
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
  registration?.call(ServiceLocator.instance, environmentFilter: environmentFilter);
  await asyncRegistration?.call(ServiceLocator.instance, environmentFilter: environmentFilter);
}

const Environment platformWeb = Environment('web');

const Environment platformMobile = Environment('mobile');

const Environment platformDesktop = Environment('desktop');

const Environment release = Environment('release');

const Environment debug = Environment('debug');
