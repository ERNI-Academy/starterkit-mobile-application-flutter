import 'dart:io';

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
  static final GetIt instance = GetIt.instance..allowReassignment = true;

  static Future<void> registerDependencies({bool forTesting = false}) async {
    final environmentFilter = NoEnvOrContainsAny(_getEnvironments(forTesting));

    await $register(ServiceLocator.instance, environmentFilter: environmentFilter);

    // We register `ApiEndpoints.baseUrl` here since its value is determined during runtime.
    ServiceLocator.instance.registerSingleton(ApiEndpoints.baseUrl, instanceName: apiBaseUrl.name);
  }

  static Set<String> _getEnvironments(bool forTesting) {
    return <String>{
      if (forTesting) testing.name else running.name,
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

const Environment testing = Environment('testing');

const Environment running = Environment('running');
