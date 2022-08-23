import 'package:erni_mobile/business/services/platform/connectivity_service_impl.dart';
import 'package:erni_mobile/common/localization/localization.dart';
import 'package:erni_mobile/domain/services/ui/dialog_service.dart';
import 'package:erni_mobile_blueprint_core/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../unit_test_utils.dart';
import 'connectivity_service_impl_test.mocks.dart';

@GenerateMocks([
  ConnectivityUtil,
  DialogService,
])
void main() {
  group(ConnectivityServiceImpl, () {
    late MockConnectivityUtil mockConnectivityUtil;
    late MockDialogService mockDialogService;

    setUp(() {
      mockConnectivityUtil = MockConnectivityUtil();
      mockDialogService = MockDialogService();
    });

    ConnectivityServiceImpl createUnitToTest() {
      return ConnectivityServiceImpl(mockConnectivityUtil, mockDialogService);
    }

    test('isConnected should call ensureConnected when called', () async {
      // Arrange
      final unitToTest = createUnitToTest();

      // Act
      await unitToTest.isConnected();

      // Assert
      verify(mockConnectivityUtil.ensureConnected()).called(1);
    });

    test('isConnected should return true when ensureConnected does not throw NoInternetException', () async {
      // Arrange
      final unitToTest = createUnitToTest();
      when(mockConnectivityUtil.ensureConnected()).thenReturn(null);

      // Act
      final result = await unitToTest.isConnected();

      // Assert
      expect(result, true);
    });

    test('isConnected should return false when ensureConnected throws NoInternetException', () async {
      // Arrange
      final unitToTest = createUnitToTest();
      when(mockConnectivityUtil.ensureConnected()).thenThrow(const NoInternetException());

      // Act
      final result = await unitToTest.isConnected();

      // Assert
      expect(result, false);
    });

    test(
      'isConnected should show alert when ensureConnected throws NoInternetException and showAlert is true',
      () async {
        // Arrange
        await setupLocale();
        final unitToTest = createUnitToTest();
        when(mockConnectivityUtil.ensureConnected()).thenThrow(const NoInternetException());

        // Act
        await unitToTest.isConnected(showAlert: true);

        // Assert
        verify(
          mockDialogService.alert(
            Il8n.current.dialogConnectionProblemMessage,
            title: Il8n.current.dialogConnectionProblemTitle,
          ),
        ).called(1);
      },
    );

    test(
      'isConnected should not show alert when ensureConnected throws NoInternetException and showAlert is false',
      () async {
        // Arrange
        await setupLocale();
        final unitToTest = createUnitToTest();
        when(mockConnectivityUtil.ensureConnected()).thenThrow(const NoInternetException());

        // Act
        await unitToTest.isConnected();

        // Assert
        verifyNever(
          mockDialogService.alert(
            Il8n.current.dialogConnectionProblemMessage,
            title: Il8n.current.dialogConnectionProblemTitle,
          ),
        );
      },
    );

    test('isConnected should return false when ensureConnected throws NoInternetException', () async {
      // Arrange
      final unitToTest = createUnitToTest();
      when(mockConnectivityUtil.ensureConnected()).thenThrow(const NoInternetException());

      // Act
      final result = await unitToTest.isConnected();

      // Assert
      expect(result, false);
    });
  });
}
