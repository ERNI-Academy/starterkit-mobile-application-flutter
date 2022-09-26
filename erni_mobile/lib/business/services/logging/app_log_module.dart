// coverage:ignore-file

import 'package:erni_mobile/domain/services/logging/app_log_console_writer.dart';
import 'package:erni_mobile/domain/services/logging/app_log_file_writer.dart';
import 'package:erni_mobile/domain/services/logging/app_log_sentry_exception_writer.dart';
import 'package:erni_mobile/domain/services/logging/app_log_writer.dart';
import 'package:erni_mobile/domain/services/platform/environment_config.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

@module
abstract class AppLogModule {
  @lazySingleton
  @preResolve
  Future<Iterable<AppLogWriter>> getLogWriters(
    AppLogConsoleWriter consoleWriter,
    AppLogFileWriter fileWriter,
    AppLogSentryExceptionWriter sentryWriter,
    EnvironmentConfig environmentConfig,
  ) async {
    await SentryFlutter.init((options) => options.dsn = environmentConfig.sentryDsn);

    return List.unmodifiable(<AppLogWriter>[consoleWriter, fileWriter, sentryWriter]);
  }

  @lazySingleton
  Hub getSentryHub() => HubAdapter();
}
