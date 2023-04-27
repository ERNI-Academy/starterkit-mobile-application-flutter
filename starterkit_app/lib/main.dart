import 'dart:async';

import 'package:flutter/material.dart';
import 'package:starterkit_app/core/app.dart';
import 'package:starterkit_app/core/dependency_injection.dart';
import 'package:starterkit_app/core/infrastructure/logging/logger.dart';
import 'package:starterkit_app/main.reflectable.dart';
import 'package:starterkit_app/shared/localization/localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeReflectable();

  ServiceLocator.registerDependencies();
  await Il8n.load(const Locale('en'));

  final zoneLogger = ServiceLocator.instance<Logger>();
  runZonedGuarded(
    () => runApp(const App()),
    (ex, st) => zoneLogger.log(LogLevel.error, 'Unhandled error', ex, st),
  );
}
