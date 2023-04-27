import 'package:injectable/injectable.dart';

abstract class EnvironmentVariables {
  String get appEnvironment;

  String get appServerUrl;
}

@LazySingleton(as: EnvironmentVariables)
class EnvironmentVariablesImpl implements EnvironmentVariables {
  @override
  String get appEnvironment => const String.fromEnvironment('appEnvironment');

  @override
  String get appServerUrl => const String.fromEnvironment('appServerUrl');
}
