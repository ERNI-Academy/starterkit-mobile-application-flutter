import 'package:drift/drift.dart';
import 'package:erni_mobile/data/web/apis/api.dart';
import 'package:erni_mobile/dependency_injection.config.dart';
import 'package:erni_mobile_blueprint_core/dependency_injection.dart';

@InjectableInit(
  initializerName: r'$register',
  preferRelativeImports: false,
  asExtension: false,
)
Future<void> registerDependencies({bool isTest = false}) async {
  await ServiceLocator.registerDependencies(isTest: isTest, asyncRegistration: $register);

  driftRuntimeOptions.dontWarnAboutMultipleDatabases = isTest;

  // We register `ApiEndpoints.baseUrl` here since its value is determined during runtime.
  ServiceLocator.instance.registerSingleton(ApiEndpoints.baseUrl, instanceName: apiBaseUrl.name);
}
