import 'dart:async';

import 'package:flutter/material.dart';
import 'package:starterkit_app/core/dependency_injection.dart';
import 'package:starterkit_app/core/infrastructure/logging/logger.dart';
import 'package:starterkit_app/features/app/presentation/views/app.dart';
import 'package:starterkit_app/main.reflectable.dart';
import 'package:starterkit_app/shared/localization/localization.dart';

Future<void> main() async {
  initializeReflectable();
  ServiceLocator.registerDependencies();

  final zoneLogger = ServiceLocator.instance<Logger>();
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Il8n.load(const Locale('en'));
      runApp(const App());
    },
    (ex, st) => zoneLogger.log(LogLevel.error, 'Unhandled error', ex, st),
  );
}
