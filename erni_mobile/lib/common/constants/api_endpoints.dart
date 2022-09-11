import 'package:erni_mobile/dependency_injection.dart';
import 'package:erni_mobile/domain/services/platform/environment_config.dart';

abstract class ApiEndpoints {
  static final String baseUrl = ServiceLocator.instance<EnvironmentConfig>().appServerUrl;
}
