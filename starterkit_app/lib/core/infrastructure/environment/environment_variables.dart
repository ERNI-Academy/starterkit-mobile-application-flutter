// coverage:ignore-file

import 'package:injectable/injectable.dart';

abstract interface class EnvironmentVariables {
  String get appId;

  String get appEnvironment;

  String get appServerUrl;
}

@LazySingleton(as: EnvironmentVariables)
class EnvironmentVariablesImpl implements EnvironmentVariables {
  @override
  String get appId => const String.fromEnvironment('appId') + const String.fromEnvironment('appIdSuffix');

  @override
  String get appEnvironment => const String.fromEnvironment('appEnvironment');

  @override
  String get appServerUrl => const String.fromEnvironment('appServerUrl');
}
