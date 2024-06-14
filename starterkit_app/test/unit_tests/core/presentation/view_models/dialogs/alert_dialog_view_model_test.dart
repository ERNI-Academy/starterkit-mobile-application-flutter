import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:starterkit_app/core/presentation/dialogs/dialog_action.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_service.dart';
import 'package:starterkit_app/core/presentation/view_models/dialogs/alert_dialog_view_model.dart';

import 'alert_dialog_view_model_test.mocks.dart';

@GenerateNiceMocks(<MockSpec<Object>>[
  MockSpec<NavigationService>(),
])
void main() {
  group(AlertDialogViewModel, () {
    late MockNavigationService mockNavigationService;

    setUp(() {
      mockNavigationService = MockNavigationService();
    });

    AlertDialogViewModel createUnitToTest() {
      return AlertDialogViewModel(mockNavigationService);
    }

    group('onPrimaryButtonPressed', () {
      test('should pop DialogAction.primary result on call', () async {
        const DialogAction expectedResult = DialogAction.primary;

        final AlertDialogViewModel unit = createUnitToTest();
        await unit.onPrimaryButtonPressed();

        verify(mockNavigationService.pop(expectedResult)).called(1);
      });
    });

    group('onSecondaryButtonPressed', () {
      test('should pop DialogAction.secondary result on call', () async {
        const DialogAction expectedResult = DialogAction.secondary;

        final AlertDialogViewModel unit = createUnitToTest();
        await unit.onSecondaryButtonPressed();

        verify(mockNavigationService.pop(expectedResult)).called(1);
      });
    });
  });
}
