import 'dart:io';

import 'package:drift/drift.dart';
import 'package:erni_mobile/data/web/apis/api.dart';
import 'package:erni_mobile/dependency_injection.config.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@InjectableInit(
  initializerName: r'$register',
  preferRelativeImports: false,
  asExtension: false,
)
abstract class ServiceLocator {
  static late final GetIt instance;

  static Future<void> registerDependencies({bool isTest = false}) async {
    final environmentFilter = NoEnvOrContainsAny(_getEnvironments(isTest));
    ServiceLocator.instance = GetIt.instance..allowReassignment = true;

    await $register(ServiceLocator.instance, environmentFilter: environmentFilter);

    driftRuntimeOptions.dontWarnAboutMultipleDatabases = isTest;

    // We register `ApiEndpoints.baseUrl` here since its value is determined during runtime.
    ServiceLocator.instance.registerSingleton(ApiEndpoints.baseUrl, instanceName: apiBaseUrl.name);
  }

  static Set<String> _getEnvironments(bool isTest) {
    return <String>{
      if (isTest) test.name else prod.name,
      if (kReleaseMode) release.name,
      if (kDebugMode) debug.name,
      if (kIsWeb) platformWeb.name,
      if (Platform.isAndroid || Platform.isIOS) platformMobile.name,
      if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) platformDesktop.name,
    };
  }
}

const Environment platformWeb = Environment('web');

const Environment platformMobile = Environment('mobile');

const Environment platformDesktop = Environment('desktop');

const Environment release = Environment('release');

const Environment debug = Environment('debug');
