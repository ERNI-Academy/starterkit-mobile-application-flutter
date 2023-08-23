import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/infrastructure/platform/environment_variables.dart';
import 'package:starterkit_app/core/service_locator.dart';

@module
abstract class PlatformModule {
  const PlatformModule();

  @lazySingleton
  @appServerUrl
  String getAppServerUrl(EnvironmentVariables environmentVariables) => environmentVariables.appServerUrl;
}
