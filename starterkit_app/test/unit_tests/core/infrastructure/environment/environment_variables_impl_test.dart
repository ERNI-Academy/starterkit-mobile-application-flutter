import 'package:flutter_test/flutter_test.dart';
import 'package:starterkit_app/core/infrastructure/environment/environment_variables.dart';

// Updates `test/assets/test_secrets.json` when you add new variables to `EnvironmentVariables`.
void main() {
  group(EnvironmentVariablesImpl, () {
    EnvironmentVariablesImpl createUnitToTest() {
      return EnvironmentVariablesImpl();
    }

    group('appEnvironment', () {
      test('should return correct value when called', () {
        const String expectedAppEnvironment = String.fromEnvironment('appEnvironment');
        final EnvironmentVariables unit = createUnitToTest();

        final String actualAppEnvironment = unit.appEnvironment;

        expect(actualAppEnvironment, isNotEmpty);
        expect(actualAppEnvironment, equals(expectedAppEnvironment));
      });
    });

    group('appServerUrl', () {
      test('should return correct value when called', () {
        const String expectedAppServerUrl = String.fromEnvironment('appServerUrl');
        final EnvironmentVariables unit = createUnitToTest();

        final String actualAppServerUrl = unit.appServerUrl;

        expect(actualAppServerUrl, isNotEmpty);
        expect(actualAppServerUrl, equals(expectedAppServerUrl));
      });
    });
  });
}
