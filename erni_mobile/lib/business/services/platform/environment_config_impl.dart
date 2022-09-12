import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/business/models/platform/app_environment.dart';
import 'package:erni_mobile/domain/services/platform/environment_config.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@LazySingleton(as: EnvironmentConfig)
class EnvironmentConfigImpl implements EnvironmentConfig {
  @override
  final String sessionId = const Uuid().v1();

  @override
  AppEnvironment get appEnvironment => AppEnvironment.values.byName(const String.fromEnvironment('appEnvironment'));

  @override
  String get appName => const String.fromEnvironment('appName', defaultValue: 'App');

  @override
  String get appServerUrl => const String.fromEnvironment('appServerUrl');

  @override
  String get sentryDsn => const String.fromEnvironment('sentryDsn');

  @override
  LogLevel get minLogLevel =>
      LogLevel.values.byName(const String.fromEnvironment('appMinLogLevel', defaultValue: 'off'));
}
