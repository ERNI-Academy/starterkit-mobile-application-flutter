import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:starterkit_app/core/infrastructure/logging/logger.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_logger.dart';

import '../../../../test_matchers.dart';
import 'navigation_logger_test.mocks.dart';

@GenerateNiceMocks(<MockSpec<Object>>[
  MockSpec<Logger>(),
  MockSpec<RouteData>(),
  MockSpec<RouteMatch<Object?>>(),
])
void main() {
  group(NavigationLogger, () {
    late MockLogger mockLogger;

    setUp(() {
      mockLogger = MockLogger();
    });

    NavigationLogger createUnitToTest() {
      return NavigationLogger(mockLogger);
    }

    group('didPush', () {
      test('should log information when called', () {
        final NavigationLogger unit = createUnitToTest();

        unit.didPush(MaterialPageRoute<void>(builder: (BuildContext context) => const SizedBox()), null);

        final VerificationResult logVerificationResult =
            verify(mockLogger.log(LogLevel.info, captureAnyInstanceOf<String>()))..called(1);
        final String? actualLogMessage = logVerificationResult.captured.singleOrNull as String?;
        expect(actualLogMessage, contains('PUSHED'));
      });

      test('should log route path when called', () {
        const String expectedRoutePath = '/test';
        final MockRouteData mockRouteData = MockRouteData();
        final MockRouteMatch mockRouteMatch = MockRouteMatch();
        when(mockRouteData.path).thenReturn(expectedRoutePath);
        when(mockRouteData.route).thenReturn(mockRouteMatch);
        final NavigationLogger unit = createUnitToTest();

        unit.didPush(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const SizedBox(),
            settings: AutoRoutePage<void>(
              routeData: mockRouteData,
              child: const SizedBox(),
            ),
          ),
          null,
        );

        final VerificationResult logVerificationResult =
            verify(mockLogger.log(LogLevel.info, captureAnyInstanceOf<String>()))..called(1);
        final String? actualLogMessage = logVerificationResult.captured.singleOrNull as String?;
        expect(actualLogMessage, contains(expectedRoutePath));
      });
    });

    group('didPop', () {
      test('should log information when called', () {
        final NavigationLogger unit = createUnitToTest();

        unit.didPop(MaterialPageRoute<void>(builder: (BuildContext context) => const SizedBox()), null);

        final VerificationResult logVerificationResult =
            verify(mockLogger.log(LogLevel.info, captureAnyInstanceOf<String>()))..called(1);
        final String? actualLogMessage = logVerificationResult.captured.singleOrNull as String?;
        expect(actualLogMessage, contains('POPPED'));
      });

      test('should log route path when called', () {
        const String expectedRoutePath = '/test';
        final MockRouteData mockRouteData = MockRouteData();
        final MockRouteMatch mockRouteMatch = MockRouteMatch();
        when(mockRouteData.path).thenReturn(expectedRoutePath);
        when(mockRouteData.route).thenReturn(mockRouteMatch);
        final NavigationLogger unit = createUnitToTest();

        unit.didPop(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const SizedBox(),
            settings: AutoRoutePage<void>(
              routeData: mockRouteData,
              child: const SizedBox(),
            ),
          ),
          null,
        );

        final VerificationResult logVerificationResult =
            verify(mockLogger.log(LogLevel.info, captureAnyInstanceOf<String>()))..called(1);
        final String? actualLogMessage = logVerificationResult.captured.singleOrNull as String?;
        expect(actualLogMessage, contains(expectedRoutePath));
      });
    });

    group('didReplace', () {
      test('should log information when called', () {
        final NavigationLogger unit = createUnitToTest();

        unit.didReplace(newRoute: null, oldRoute: null);

        final VerificationResult logVerificationResult =
            verify(mockLogger.log(LogLevel.info, captureAnyInstanceOf<String>()))..called(1);
        final String? actualLogMessage = logVerificationResult.captured.singleOrNull as String?;
        expect(actualLogMessage, contains('REPLACED'));
      });

      test('should log route path when called', () {
        const String expectedRoutePath = '/test';
        final MockRouteData mockRouteData = MockRouteData();
        final MockRouteMatch mockRouteMatch = MockRouteMatch();
        when(mockRouteData.path).thenReturn(expectedRoutePath);
        when(mockRouteData.route).thenReturn(mockRouteMatch);
        final NavigationLogger unit = createUnitToTest();

        unit.didReplace(
          newRoute: MaterialPageRoute<void>(
            builder: (BuildContext context) => const SizedBox(),
            settings: AutoRoutePage<void>(
              routeData: mockRouteData,
              child: const SizedBox(),
            ),
          ),
          oldRoute: null,
        );

        final VerificationResult logVerificationResult =
            verify(mockLogger.log(LogLevel.info, captureAnyInstanceOf<String>()))..called(1);
        final String? actualLogMessage = logVerificationResult.captured.singleOrNull as String?;
        expect(actualLogMessage, contains(expectedRoutePath));
      });
    });
  });
}
