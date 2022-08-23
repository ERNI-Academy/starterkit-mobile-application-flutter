import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(LogLevel, () {
    test('enums should return correct enum value when called', () {
      // Arrange
      final expectedEnumNumericValues = {
        LogLevel.off: 0,
        LogLevel.debug: 100,
        LogLevel.info: 200,
        LogLevel.warning: 300,
        LogLevel.error: 400,
      };
      const actualEnums = LogLevel.values;

      // Assert
      for (final actualEnum in actualEnums) {
        expect(actualEnum.value, expectedEnumNumericValues[actualEnum]);
      }
    });
  });
}
