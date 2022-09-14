import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/business/models/platform/app_environment.dart';

abstract class EnvironmentConfig {
  AppEnvironment get appEnvironment;

  String get appName;

  String get appServerUrl;

  String get sentryDsn;

  LogLevel get minLogLevel;

  String get sessionId;
}
