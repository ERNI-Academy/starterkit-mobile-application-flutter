import 'dart:async';

import 'package:flutter/material.dart';
import 'package:starterkit_app/common/localization/generated/l10n.dart';
import 'package:starterkit_app/core/infrastructure/logging/logger.dart';
import 'package:starterkit_app/core/service_locator.dart';
import 'package:starterkit_app/main.reflectable.dart';
import 'package:starterkit_app/presentation/app/views/app.dart';

Future<void> main() async {
  initializeReflectable();
  ServiceLocator.registerDependencies();

  final Logger zoneLogger = ServiceLocator.instance<Logger>();
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Il8n.load(const Locale('en'));
      runApp(const App());
    },
    (Object ex, StackTrace st) => zoneLogger.log(LogLevel.error, 'Unhandled error', ex, st),
  );
}
