import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/business/services/logging/navigation_logger_impl.dart';
import 'package:erni_mobile/domain/services/logging/app_logger.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../unit_test_utils.dart';
import 'navigation_logger_impl_test.mocks.dart';

@GenerateMocks([
  AppLogger,
  Route,
])
void main() {
  group(NavigationLoggerImpl, () {
    late MockAppLogger mockAppLogger;

    setUp(() {
      mockAppLogger = MockAppLogger();
    });

    NavigationLoggerImpl createUnitToTest() => NavigationLoggerImpl(mockAppLogger);

    Route<void> createAndSetupRoute({String? name}) {
      final route = MockRoute<void>();
      when(route.settings).thenReturn(RouteSettings(name: name));

      return route;
    }

    test('constructor should log itself when called', () {
      // Act
      final unit = createUnitToTest();

      // Assert
      verify(mockAppLogger.logFor(unit)).called(1);
    });

    test('didPush should log the next route\'s name when not null', () {
      // Arrange
      const expectedRouteName = 'route-name';
      final unit = createUnitToTest();
      final nextRoute = createAndSetupRoute(name: expectedRouteName);

      // Act
      unit.didPush(nextRoute, null);

      // Assert
      verify(mockAppLogger.log(LogLevel.info, 'Pushed $expectedRouteName')).called(1);
    });

    test('didPush should not log the next route\'s name when null', () {
      // Arrange
      final unit = createUnitToTest();
      final nextRoute = createAndSetupRoute();

      // Act
      unit.didPush(nextRoute, null);

      // Assert
      verifyNever(mockAppLogger.log(LogLevel.info, anyInstanceOf<String>()));
    });

    test('didPop should log the popped route\'s name when not null', () {
      // Arrange
      const expectedRouteName = 'route-name';
      final unit = createUnitToTest();
      final popped = createAndSetupRoute(name: expectedRouteName);

      // Act
      unit.didPop(popped, null);

      // Assert
      verify(mockAppLogger.log(LogLevel.info, 'Popped $expectedRouteName')).called(1);
    });

    test('didPop should not log the popped route\'s name when null', () {
      // Arrange
      final unit = createUnitToTest();
      final popped = createAndSetupRoute();

      // Act
      unit.didPop(popped, null);

      // Assert
      verifyNever(mockAppLogger.log(LogLevel.info, anyInstanceOf<String>()));
    });

    test('didReplace should log the new route\'s name when not null', () {
      // Arrange
      const expectedRouteName = 'route-name';
      final unit = createUnitToTest();
      final popped = createAndSetupRoute(name: expectedRouteName);

      // Act
      unit.didReplace(newRoute: popped);

      // Assert
      verify(mockAppLogger.log(LogLevel.info, 'Replaced with $expectedRouteName')).called(1);
    });

    test('didReplace should not log the new route\'s name when null', () {
      // Arrange
      final unit = createUnitToTest();
      final popped = createAndSetupRoute();

      // Act
      unit.didReplace(newRoute: popped);

      // Assert
      verifyNever(mockAppLogger.log(LogLevel.info, anyInstanceOf<String>()));
    });
  });
}
