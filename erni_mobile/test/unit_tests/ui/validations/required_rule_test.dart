import 'package:erni_mobile/common/localization/localization.dart';
import 'package:erni_mobile/ui/validations/required_rule.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../unit_test_utils.dart';

void main() {
  group(RequiredRule, () {
    RequiredRule createUnitToTest() => const RequiredRule();

    test('errorMessage should return validationRequiredField localized string when called', () async {
      // Arrange
      final unit = createUnitToTest();
      await setupLocale();

      // Act
      final actualErrorMessage = unit.errorMessage;

      // Assert
      expect(actualErrorMessage, Il8n.current.validationRequiredField);
    });

    test('checkIsValid should return true when value is not null', () {
      // Arrange
      final unit = createUnitToTest();

      // Act
      final actualIsValid = unit.checkIsValid(Object());

      // Assert
      expect(actualIsValid, true);
    });

    test('checkIsValid should return true when value is non-null string', () {
      // Arrange
      const validValue = 'some value';
      final unit = createUnitToTest();

      // Act
      final actualResult = unit.checkIsValid(validValue);

      // Assert
      expect(actualResult, true);
    });

    test('checkIsValid should return false when value is null string', () {
      // Arrange
      const String? invalidValue = null;
      final unit = createUnitToTest();

      // Act
      final actualResult = unit.checkIsValid(invalidValue);

      // Assert
      expect(actualResult, false);
    });

    test('checkIsValid should return false when value is empty string', () {
      // Arrange
      const invalidValue = '';
      final unit = createUnitToTest();

      // Act
      final actualResult = unit.checkIsValid(invalidValue);

      // Assert
      expect(actualResult, false);
    });
  });
}
