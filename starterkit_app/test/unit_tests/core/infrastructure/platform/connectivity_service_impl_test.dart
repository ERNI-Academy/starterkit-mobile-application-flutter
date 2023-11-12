import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:starterkit_app/core/infrastructure/platform/connectivity_service.dart';

import 'connectivity_service_impl_test.mocks.dart';

@GenerateNiceMocks(<MockSpec<Object>>[
  MockSpec<Connectivity>(),
])
void main() {
  group(ConnectivityServiceImpl, () {
    late MockConnectivity mockConnectivity;

    setUp(() {
      mockConnectivity = MockConnectivity();
    });

    ConnectivityServiceImpl createUnitToTest() {
      return ConnectivityServiceImpl(mockConnectivity);
    }

    group('isConnected', () {
      test('should return true when connected to wifi, mobile, or ethernet', () async {
        final List<ConnectivityResult> expectedStatuses = <ConnectivityResult>[
          ConnectivityResult.wifi,
          ConnectivityResult.mobile,
          ConnectivityResult.ethernet,
        ];
        final ConnectivityServiceImpl unit = createUnitToTest();

        for (final ConnectivityResult status in expectedStatuses) {
          when(mockConnectivity.checkConnectivity()).thenAnswer((_) async => status);

          final bool actualIsConnected = await unit.isConnected();

          expect(actualIsConnected, isTrue);
        }
      });

      test('should return false when not connected to wifi, mobile, or ethernet', () async {
        final List<ConnectivityResult> expectedStatuses = ConnectivityResult.values.toList()
          ..removeWhere((ConnectivityResult element) =>
              element == ConnectivityResult.wifi ||
              element == ConnectivityResult.mobile ||
              element == ConnectivityResult.ethernet);
        final ConnectivityServiceImpl unit = createUnitToTest();

        for (final ConnectivityResult status in expectedStatuses) {
          when(mockConnectivity.checkConnectivity()).thenAnswer((_) async => status);

          final bool actualIsConnected = await unit.isConnected();

          expect(actualIsConnected, isFalse);
        }
      });
    });
  });
}
