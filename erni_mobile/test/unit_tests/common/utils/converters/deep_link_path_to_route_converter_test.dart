import 'package:erni_mobile/common/constants/deep_link_paths.dart';
import 'package:erni_mobile/common/constants/route_names.dart';
import 'package:erni_mobile/common/utils/converters/deep_link_path_to_route_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(DeepLinkPathToRouteConverter, () {
    DeepLinkPathToRouteConverter createUnitToTest() => const DeepLinkPathToRouteConverter();

    test('convert should return known route name when parameter is a known deep link path', () {
      // Arrange
      const actualPaths = [DeepLinkPaths.setInitialPassword, DeepLinkPaths.resetPassword];
      const expectedRouteNames = [RouteNames.setInitialPassword, RouteNames.resetPassword];
      final unit = createUnitToTest();

      for (int i = 0; i < actualPaths.length; i++) {
        // Act
        final actualRouteName = unit.convert(actualPaths[i]);

        // Assert
        expect(actualRouteName, expectedRouteNames[i]);
      }
    });

    test('convert should return empty string when parameter is unknown deep link path', () {
      // Arrange
      const actualPath = 'unknown';
      final unit = createUnitToTest();

      // Act
      final actualRouteName = unit.convert(actualPath);

      // Assert
      expect(actualRouteName, '');
    });

    test('convertBack should return known deep link path when parameter is a known route name', () {
      // Arrange
      const actualRouteNames = [RouteNames.setInitialPassword, RouteNames.resetPassword];
      const expectedPaths = [DeepLinkPaths.setInitialPassword, DeepLinkPaths.resetPassword];
      final unit = createUnitToTest();

      // Assert
      for (int i = 0; i < actualRouteNames.length; i++) {
        // Act
        final actualPath = unit.convertBack(actualRouteNames[i]);

        // Assert
        expect(actualPath, expectedPaths[i]);
      }
    });

    test('convertBack should return empty string when parameter is unknown route name', () {
      // Arrange
      const actualRouteName = 'unknown';
      final unit = createUnitToTest();

      // Act
      final actualPath = unit.convertBack(actualRouteName);

      // Assert
      expect(actualPath, '');
    });
  });
}
