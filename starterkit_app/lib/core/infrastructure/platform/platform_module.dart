import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/dependency_injection.dart';
import 'package:starterkit_app/core/infrastructure/platform/environment_variables.dart';

@module
abstract class PlatformModule {
  @lazySingleton
  @appServerUrl
  String getAppServerUrl(EnvironmentVariables environmentVariables) => environmentVariables.appServerUrl;
}
