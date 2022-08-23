import 'dart:convert';

import 'package:erni_mobile/common/utils/converters/base64_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(Base64Converter, () {
    Codec<String, String> createStringToBase64Codec() => utf8.fuse(base64);

    Base64Converter createUnitToTest() => const Base64Converter();

    test('convert should return decoded string when parameter is base64 string', () {
      // Arrange
      const actualString = 'test';
      final expectedEncodedString = createStringToBase64Codec().encode(actualString);
      final expectedDecodedString = createStringToBase64Codec().decode(expectedEncodedString);
      final unit = createUnitToTest();

      // Act
      final actualDecodedString = unit.convert(expectedEncodedString);

      // Assert
      expect(actualDecodedString, expectedDecodedString);
    });

    test('convertBack should return encoded string when parameter is decoded string', () {
      // Arrange
      const actualString = 'test';
      final expectedEncodedString = createStringToBase64Codec().encode(actualString);
      final expectedDecodedString = createStringToBase64Codec().decode(expectedEncodedString);
      final unit = createUnitToTest();

      // Act
      final actualEncodedString = unit.convertBack(expectedDecodedString);

      // Assert
      expect(actualEncodedString, expectedEncodedString);
    });
  });
}
