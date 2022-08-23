import 'package:erni_mobile/business/models/logging/log_level.dart';

abstract class EnvironmentConfig {
  String get appEnvironment;

  String get appName;

  String get appServerUrl;

  String get sentryDsn;

  LogLevel get minLogLevel;

  String get sessionId;
}
