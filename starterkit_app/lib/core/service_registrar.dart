// coverage:ignore-file

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:starterkit_app/core/service_registrar.config.dart';

const Named appServerUrl = Named('apiBaseUrl');

// ignore: invalid_annotation_target
@InjectableInit(
  initializerName: r'$register',
  preferRelativeImports: false,
  asExtension: false,
)
abstract interface class ServiceRegistrar {
  static GetIt? _instanceRef;

  static GetIt get _instance {
    if (_instanceRef == null) {
      throw StateError('GetIt is not initialized, did you forget to call ServiceRegistrar.registerDependencies()?');
    }

    return _instanceRef!;
  }

  static void registerDependencies() {
    final GetIt getIt = GetIt.instance..allowReassignment = true;
    _instanceRef = $register(getIt);
  }

  @visibleForTesting
  static void registerLazySingleton<T extends Object>(FactoryFunc<T> factoryFunc, {String? instanceName}) {
    _instance.registerLazySingleton<T>(factoryFunc, instanceName: instanceName);
  }
}
