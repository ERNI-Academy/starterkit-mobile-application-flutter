import 'package:erni_mobile/common/localization/localization.dart';
import 'package:erni_mobile/ui/validations/email_format_rule.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../unit_test_utils.dart';

void main() {
  group(EmailFormatRule, () {
    EmailFormatRule createUnitToTest() => const EmailFormatRule();

    test('errorMessage should return validationInvalidEmailFormat localized string when called', () async {
      // Arrange
      final unit = createUnitToTest();
      await setupLocale();

      // Act
      final actualErrorMessage = unit.errorMessage;

      // Assert
      expect(actualErrorMessage, Il8n.current.validationInvalidEmailFormat);
    });

    test('checkIsValid should return true when value is valid', () async {
      // Arrange
      const validEmail = 'some@email.com';
      final unit = createUnitToTest();

      // Act
      final actualResult = unit.checkIsValid(validEmail);

      // Assert
      expect(actualResult, true);
    });

    test('checkIsValid should return false when value is invalid', () async {
      // Arrange
      const invalidEmail = 'someemail.com';
      final unit = createUnitToTest();

      // Act
      final actualResult = unit.checkIsValid(invalidEmail);

      // Assert
      expect(actualResult, false);
    });

    test('checkIsValid should return false when value is null', () async {
      // Arrange
      final unit = createUnitToTest();

      // Act
      final actualResult = unit.checkIsValid(null);

      // Assert
      expect(actualResult, false);
    });
  });
}
