import 'package:flutter_test/flutter_test.dart';
import 'package:starterkit_app/core/service_registrar.dart';

void main() {
  group(ServiceRegistrar, () {
    group('instance', () {
      test('should throw UnsupportedError when registerDependencies not called', () {
        expect(() => ServiceRegistrar.registerLazySingleton<String>(() => ''), throwsUnsupportedError);
      });
    });
  });
}
