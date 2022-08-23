import 'dart:convert';

import 'package:erni_mobile/data/database/logging/converters/database_map_to_string_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(DatabaseMapToStringConverter, () {
    DatabaseMapToStringConverter createUnitToTest() => const DatabaseMapToStringConverter();

    test('mapToDart should return correct map when parameter is string', () {
      // Arrange
      const actualString = '{"a": 1, "b": 2}';
      final expectedResult = (jsonDecode(actualString) as Map).cast<String, Object>();
      final unitToTest = createUnitToTest();

      // Act
      final actualResult = unitToTest.mapToDart(actualString);

      // Assert
      expect(actualResult, expectedResult);
    });

    test('mapToDart should return null when parameter is null', () {
      // Arrange
      final unitToTest = createUnitToTest();

      // Act
      final actualResult = unitToTest.mapToDart(null);

      // Assert
      expect(actualResult, null);
    });

    test('mapToSql should return correct string when parameter is map', () {
      // Arrange
      final actualMap = {'a': 1, 'b': 2};
      final expectedResult = jsonEncode(actualMap);
      final unitToTest = createUnitToTest();

      // Act
      final actualResult = unitToTest.mapToSql(actualMap);

      // Assert
      expect(actualResult, expectedResult);
    });

    test('mapToSql should return null when parameter is null', () {
      // Arrange
      final unitToTest = createUnitToTest();

      // Act
      final actualResult = unitToTest.mapToSql(null);

      // Assert
      expect(actualResult, null);
    });
  });
}
