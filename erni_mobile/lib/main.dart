import 'dart:async';

import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/common/localization/generated/l10n.dart';
import 'package:erni_mobile/dependency_injection.dart';
import 'package:erni_mobile/domain/services/logging/app_logger.dart';
import 'package:erni_mobile/ui/views/main/app.dart';
import 'package:flutter/widgets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await registerDependencies();
  await Il8n.load(const Locale('en'));
  runZonedGuarded(
    () => runApp(App()),
    (ex, st) => ServiceLocator.instance<AppLogger>().log(LogLevel.error, 'Unhandled error', ex, st),
  );
}
