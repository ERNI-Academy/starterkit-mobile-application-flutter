import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_service.dart';
import 'package:starterkit_app/core/presentation/navigation/root_auto_router.dart';

import 'navigation_service_impl_test.mocks.dart';

@GenerateNiceMocks(<MockSpec<Object>>[
  MockSpec<RootAutoRouter>(),
])
void main() {
  group(NavigationServiceImpl, () {
    late MockRootAutoRouter mockRootAutoRouter;

    setUp(() {
      mockRootAutoRouter = MockRootAutoRouter();
    });

    NavigationServiceImpl createUnitToTest() {
      return NavigationServiceImpl(mockRootAutoRouter);
    }

    group('push', () {
      test('should push new route when called', () async {
        const _MockPageRouteInfo expectedRoute = _MockPageRouteInfo('route');
        final NavigationServiceImpl unit = createUnitToTest();

        await unit.push(expectedRoute);

        verify(mockRootAutoRouter.push(expectedRoute));
      });

      test('should return result when called', () async {
        const _MockPageRouteInfo expectedRoute = _MockPageRouteInfo('route');
        const String expectedResult = 'result';
        final NavigationServiceImpl unit = createUnitToTest();
        when(mockRootAutoRouter.push(expectedRoute)).thenAnswer((_) async => expectedResult);

        final String? actualResult = await unit.push(expectedRoute);

        expect(actualResult, equals(expectedResult));
      });
    });

    group('pushToNewRoot', () {
      test('should pop until root and replace with new route when called', () {
        final NavigationServiceImpl unit = createUnitToTest();
        const _MockPageRouteInfo expectedRoute = _MockPageRouteInfo('route');

        unit.pushToNewRoot(expectedRoute);

        verify(mockRootAutoRouter.popUntilRoot());
        verify(unawaited(mockRootAutoRouter.replace(expectedRoute)));
      });
    });

    group('replace', () {
      test('should replace current route with new route when called', () async {
        const _MockPageRouteInfo expectedRoute = _MockPageRouteInfo('route');
        final NavigationServiceImpl unit = createUnitToTest();

        await unit.replace(expectedRoute);

        verify(mockRootAutoRouter.replace(expectedRoute));
      });

      test('should return result when called', () async {
        const _MockPageRouteInfo expectedRoute = _MockPageRouteInfo('route');
        const String expectedResult = 'result';
        final NavigationServiceImpl unit = createUnitToTest();
        when(mockRootAutoRouter.replace(expectedRoute)).thenAnswer((_) async => expectedResult);

        final String? actualResult = await unit.replace(expectedRoute);

        expect(actualResult, equals(expectedResult));
      });
    });
  });
}

class _MockPageRouteInfo extends PageRouteInfo {
  const _MockPageRouteInfo(super._name);
}
