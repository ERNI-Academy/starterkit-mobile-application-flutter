import 'package:erni_mobile/common/localization/localization.dart';
import 'package:erni_mobile/ui/validations/password_strength_rule.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../unit_test_utils.dart';

void main() {
  group(PasswordStrengthRule, () {
    PasswordStrengthRule createUnitToTest() => const PasswordStrengthRule();

    test('errorMessage should return validationInvalidPasswordStrength localized string when called', () async {
      // Arrange
      final unit = createUnitToTest();
      await setupLocale();

      // Act
      final actualErrorMessage = unit.errorMessage;

      // Assert
      expect(actualErrorMessage, Il8n.current.validationInvalidPasswordStrength);
    });

    test('checkIsValid should return true when value is valid', () async {
      // Arrange
      const validPassword = 'P@ssw0rd';
      final unit = createUnitToTest();

      // Act
      final actualResult = unit.checkIsValid(validPassword);

      // Assert
      expect(actualResult, true);
    });

    test('checkIsValid should return false when value is invalid', () async {
      // Arrange
      const invalidPassword = 'password';
      final unit = createUnitToTest();

      // Act
      final actualResult = unit.checkIsValid(invalidPassword);

      // Assert
      expect(actualResult, false);
    });
  });
}
