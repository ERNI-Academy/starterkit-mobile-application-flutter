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
      test('should pop primary DialogAction result when called', () async {
        final AlertDialogViewModel unit = createUnitToTest();

        await unit.onPrimaryButtonPressed();

        verify(mockNavigationService.pop(DialogAction.primary));
      });
    });

    group('onSecondaryButtonPressed', () {
      test('should pop secondary DialogAction result when called', () async {
        final AlertDialogViewModel unit = createUnitToTest();

        await unit.onSecondaryButtonPressed();

        verify(mockNavigationService.pop(DialogAction.secondary));
      });
    });
  });
}
