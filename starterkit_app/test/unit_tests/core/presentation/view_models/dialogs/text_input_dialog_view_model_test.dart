import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_service.dart';
import 'package:starterkit_app/core/presentation/view_models/dialogs/text_input_dialog_view_model.dart';

import 'text_input_dialog_view_model_test.mocks.dart';

@GenerateNiceMocks(<MockSpec<Object>>[
  MockSpec<NavigationService>(),
])
void main() {
  group(TextInputDialogViewModel, () {
    late MockNavigationService mockNavigationService;

    setUp(() {
      mockNavigationService = MockNavigationService();
    });

    TextInputDialogViewModel createUnitToTest() {
      return TextInputDialogViewModel(mockNavigationService);
    }

    group('onPrimaryButtonPressed', () {
      test('should pop text result on call', () async {
        const String expectedResult = 'test';

        final TextInputDialogViewModel unit = createUnitToTest();
        unit.text = expectedResult;
        await unit.onPrimaryButtonPressed();

        verify(mockNavigationService.maybePop(expectedResult)).called(1);
      });
    });

    group('onSecondaryButtonPressed', () {
      test('should pop null result on call', () async {
        final TextInputDialogViewModel unit = createUnitToTest();
        await unit.onSecondaryButtonPressed();

        verify(mockNavigationService.maybePop<Object>(null)).called(1);
      });
    });
  });
}
