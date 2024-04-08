import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_router.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_service.dart';

import 'navigation_service_impl_test.mocks.dart';

@GenerateNiceMocks(<MockSpec<Object>>[
  MockSpec<NavigationRouter>(),
])
void main() {
  group(NavigationService, () {
    late MockNavigationRouter mockNavigationRouter;

    setUp(() {
      mockNavigationRouter = MockNavigationRouter();
    });

    NavigationService createUnitToTest() {
      return NavigationService(mockNavigationRouter);
    }

    group('push', () {
      test('should push new route when called', () async {
        const _MockPageRouteInfo expectedRoute = _MockPageRouteInfo('route');
        final NavigationService unit = createUnitToTest();

        await unit.push(expectedRoute);

        verify(mockNavigationRouter.push(expectedRoute));
      });

      test('should return result when called', () async {
        const _MockPageRouteInfo expectedRoute = _MockPageRouteInfo('route');
        const String expectedResult = 'result';
        final NavigationService unit = createUnitToTest();
        when(mockNavigationRouter.push(expectedRoute)).thenAnswer((_) async => expectedResult);

        final String? actualResult = await unit.push(expectedRoute);

        expect(actualResult, equals(expectedResult));
      });
    });

    group('pushToNewRoot', () {
      test('should pop until root and replace with new route when called', () {
        final NavigationService unit = createUnitToTest();
        const _MockPageRouteInfo expectedRoute = _MockPageRouteInfo('route');

        unit.pushToNewRoot(expectedRoute);

        verify(mockNavigationRouter.popUntilRoot());
        verify(unawaited(mockNavigationRouter.replace(expectedRoute)));
      });
    });

    group('replace', () {
      test('should replace current route with new route when called', () async {
        const _MockPageRouteInfo expectedRoute = _MockPageRouteInfo('route');
        final NavigationService unit = createUnitToTest();

        await unit.replace(expectedRoute);

        verify(mockNavigationRouter.replace(expectedRoute));
      });

      test('should return result when called', () async {
        const _MockPageRouteInfo expectedRoute = _MockPageRouteInfo('route');
        const String expectedResult = 'result';
        final NavigationService unit = createUnitToTest();
        when(mockNavigationRouter.replace(expectedRoute)).thenAnswer((_) async => expectedResult);

        final String? actualResult = await unit.replace(expectedRoute);

        expect(actualResult, equals(expectedResult));
      });
    });
  });
}

class _MockPageRouteInfo extends PageRouteInfo {
  const _MockPageRouteInfo(super._name);
}
