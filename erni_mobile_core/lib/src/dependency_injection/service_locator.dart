import 'package:erni_mobile_core/src/dependency_injection/registration.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

abstract class ServiceLocator {
  static final GetIt instance = GetIt.instance..allowReassignment = true;

  static Future<void> registerDependencies({
    GetIt Function(GetIt get, {String? environment, EnvironmentFilter? environmentFilter})? registration,
    Future<GetIt> Function(GetIt get, {String? environment, EnvironmentFilter? environmentFilter})? asyncRegistration,
    bool isTest = false,
  }) {
    return internalRegistration(isTest: isTest, registration: registration, asyncRegistration: asyncRegistration);
  }
}
