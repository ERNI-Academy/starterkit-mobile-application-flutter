import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:starterkit_app/core/service_locator.dart';

void main() {
  group(ServiceLocator, () {
    group('instance', () {
      test('should throw UnsupportedError when registerDependencies not called', () {
        expect(() => ServiceLocator.instance, throwsUnsupportedError);
      });

      test('should return GetIt instance when registerDependencies called', () {
        ServiceLocator.registerDependencies();

        expect(ServiceLocator.instance, equals(GetIt.instance));
      });
    });
  });
}
