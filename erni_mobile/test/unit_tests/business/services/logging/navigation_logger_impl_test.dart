import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/business/services/logging/navigation_logger_impl.dart';
import 'package:erni_mobile/domain/services/logging/app_logger.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'navigation_logger_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AppLogger>(),
  MockSpec<Route>(),
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
      const expectedPreviousRouteName = 'route1';
      const expectedNewRouteName = 'route2';
      final unit = createUnitToTest();
      final nextRoute = createAndSetupRoute(name: expectedNewRouteName);
      final previousRoute = createAndSetupRoute(name: expectedPreviousRouteName);

      // Act
      unit.didPush(nextRoute, previousRoute);

      // Assert
      verify(mockAppLogger.log(LogLevel.info, '$expectedPreviousRouteName === PUSHED ==> $expectedNewRouteName'))
          .called(1);
    });

    test('didPop should log the popped route\'s name when not null', () {
      // Arrange
      const expectedPreviousRouteName = 'route1';
      const expectedPoppedRouteName = 'route2';
      final unit = createUnitToTest();
      final poppedRoute = createAndSetupRoute(name: expectedPoppedRouteName);
      final previousRoute = createAndSetupRoute(name: expectedPreviousRouteName);

      // Act
      unit.didPop(poppedRoute, previousRoute);

      // Assert
      verify(mockAppLogger.log(LogLevel.info, '$expectedPreviousRouteName <== POPPED === $expectedPoppedRouteName'))
          .called(1);
    });

    test('didReplace should log the new route\'s name when not null', () {
      // Arrange
      const expectedNewRouteName = 'route1';
      const expectedOldRouteName = 'route2';
      final unit = createUnitToTest();
      final newRoute = createAndSetupRoute(name: expectedNewRouteName);
      final oldRoute = createAndSetupRoute(name: expectedOldRouteName);

      // Act
      unit.didReplace(newRoute: newRoute, oldRoute: oldRoute);

      // Assert
      verify(mockAppLogger.log(LogLevel.info, '$expectedOldRouteName === REPLACED ==> $expectedNewRouteName'))
          .called(1);
    });
  });
}
