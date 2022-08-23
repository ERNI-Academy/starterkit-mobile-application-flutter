import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/common/utils/converters/log_level_to_string_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(LogLevelToStringConverter, () {
    LogLevelToStringConverter createUnitToTest() => const LogLevelToStringConverter();

    test('convert should return LogLevel value when parameter is a valid string value', () {
      // Arrange
      const expectedLogLevels = LogLevel.values;
      final actualLogLevelStringValues = LogLevel.values.map((e) => e.name).toList();
      final unit = createUnitToTest();

      for (int i = 0; i < expectedLogLevels.length; i++) {
        // Act
        final actualLogLevel = unit.convert(actualLogLevelStringValues[i]);

        // Assert
        expect(actualLogLevel, expectedLogLevels[i]);
      }
    });

    test('convert should throw ArgumentError when parameter is not a valid string value', () {
      // Arrange
      final unit = createUnitToTest();

      // Assert
      expect(() => unit.convert('invalid'), throwsArgumentError);
    });

    test('convertBack should return string value when parameter is LogLevel value', () {
      // Arrange
      const actualLogLevels = LogLevel.values;
      final expectedLogLevelStringValues = LogLevel.values.map((e) => e.name).toList();
      final unit = createUnitToTest();

      for (int i = 0; i < actualLogLevels.length; i++) {
        // Act
        final actualLogLevelString = unit.convertBack(actualLogLevels[i]);

        // Assert
        expect(actualLogLevelString, expectedLogLevelStringValues[i]);
      }
    });
  });
}
