import 'package:erni_mobile/common/utils/converters/json/json_date_time_to_iso8601_string_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(JsonDateTimeToIso8601StringConverter, () {
    JsonDateTimeToIso8601StringConverter createUnitToTest() => const JsonDateTimeToIso8601StringConverter();

    test('fromJson should return DateTime when parameter is ISO 8601 string format', () {
      // Arrange
      const actualIso8601String = '2022-01-01T00:00:00.000Z';
      final expectedDateTime = DateTime.parse(actualIso8601String);
      final unit = createUnitToTest();

      // Act
      final actualDateTime = unit.fromJson(actualIso8601String);

      // Assert
      expect(actualDateTime, expectedDateTime);
    });

    test('fromJson should throw FormatException when parameter is not ISO 8601 string format', () {
      // Arrange
      final unit = createUnitToTest();

      // Assert
      expect(() => unit.fromJson('Jan 1, 2022'), throwsFormatException);
    });

    test('fromJson should throw FormatException when parameter is an empty string', () {
      // Arrange
      final unit = createUnitToTest();

      // Assert
      expect(() => unit.fromJson(''), throwsFormatException);
    });

    test('toJson should return ISO 8601 string when parameter is DateTime', () {
      // Arrange
      final actualDateTime = DateTime(2022);
      final expectedIso8601String = actualDateTime.toIso8601String();
      final unit = createUnitToTest();

      // Act
      final actualIso8601String = unit.toJson(actualDateTime);

      // Assert
      expect(actualIso8601String, expectedIso8601String);
    });
  });
}
