import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:starterkit_app/common/localization/generated/l10n.dart';
import 'package:starterkit_app/core/presentation/dialogs/dialog_action.dart';
import 'package:starterkit_app/core/presentation/dialogs/dialog_service.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_service.dart';
import 'package:starterkit_app/core/presentation/navigation/root_auto_router.gr.dart';
import 'package:starterkit_app/core/presentation/view_models/dialogs/alert_dialog_view_model.dart';

import '../../../../test_matchers.dart';
import '../../../../test_utils.dart';
import 'dialog_service_impl_test.mocks.dart';

@GenerateNiceMocks(<MockSpec<Object>>[
  MockSpec<NavigationService>(),
])
void main() {
  group(DialogServiceImpl, () {
    late MockNavigationService mockNavigationService;

    setUp(() {
      mockNavigationService = MockNavigationService();
    });

    DialogServiceImpl createUnitToTest() {
      return DialogServiceImpl(mockNavigationService);
    }

    group('alert', () {
      test('should navigate to AlertDialogViewRoute when called', () async {
        const String expectedMessage = 'message';
        const String expectedTitle = 'title';
        const String expectedPrimaryText = 'primaryText';
        const String expectedSecondaryText = 'secondaryText';
        final Map<String?, String> expectedQueryParams = <String?, String>{
          messageParam.name: expectedMessage,
          primaryTextParam.name: expectedPrimaryText,
          secondaryTextParam.name: expectedSecondaryText,
          titleParam.name: expectedTitle,
        };
        final DialogServiceImpl unit = createUnitToTest();

        await unit.alert(
          message: expectedMessage,
          title: expectedTitle,
          primaryText: expectedPrimaryText,
          secondaryText: expectedSecondaryText,
        );

        verify(mockNavigationService.push(argThat(isA<AlertDialogViewRoute>()
                .having((AlertDialogViewRoute r) => r.rawQueryParams, 'rawQueryParams', expectedQueryParams))))
            .called(1);
      });
    });

    group('confirm', () {
      test('should navigate to AlertDialogViewRoute when called', () async {
        const String expectedMessage = 'message';
        const String expectedTitle = 'title';
        const String expectedPrimaryText = 'primaryText';
        const String expectedSecondaryText = 'secondaryText';
        final Map<String?, String> expectedQueryParams = <String?, String>{
          messageParam.name: expectedMessage,
          primaryTextParam.name: expectedPrimaryText,
          secondaryTextParam.name: expectedSecondaryText,
          titleParam.name: expectedTitle,
        };
        final DialogServiceImpl unit = createUnitToTest();

        await unit.confirm(
          message: expectedMessage,
          title: expectedTitle,
          primaryText: expectedPrimaryText,
          secondaryText: expectedSecondaryText,
        );

        verify(mockNavigationService.push(argThat(isA<AlertDialogViewRoute>()
                .having((AlertDialogViewRoute r) => r.rawQueryParams, 'rawQueryParams', expectedQueryParams))))
            .called(1);
      });

      test('should return result when result is not null', () async {
        const String expectedMessage = 'message';
        const String expectedTitle = 'title';
        const String expectedPrimaryText = 'primaryText';
        const String expectedSecondaryText = 'secondaryText';
        const DialogAction expectedResult = DialogAction.primary;
        final DialogServiceImpl unit = createUnitToTest();
        when(mockNavigationService.push<DialogAction>(anyInstanceOf<AlertDialogViewRoute>()))
            .thenAnswer((_) async => expectedResult);

        final DialogAction actualResult = await unit.confirm(
          message: expectedMessage,
          title: expectedTitle,
          primaryText: expectedPrimaryText,
          secondaryText: expectedSecondaryText,
        );

        expect(actualResult, equals(expectedResult));
      });

      test('should return cancelled DialogAction when result is null', () async {
        const String expectedMessage = 'message';
        const String expectedTitle = 'title';
        const String expectedPrimaryText = 'primaryText';
        const String expectedSecondaryText = 'secondaryText';
        final DialogServiceImpl unit = createUnitToTest();
        when(mockNavigationService.push<DialogAction>(anyInstanceOf<AlertDialogViewRoute>()))
            .thenAnswer((_) async => null);

        final DialogAction actualResult = await unit.confirm(
          message: expectedMessage,
          title: expectedTitle,
          primaryText: expectedPrimaryText,
          secondaryText: expectedSecondaryText,
        );

        expect(actualResult, equals(DialogAction.cancelled));
      });

      test('should set secondary text to cancel when null', () async {
        final Il8n il8n = await setupLocale();
        const String expectedMessage = 'message';
        const String expectedTitle = 'title';
        const String expectedPrimaryText = 'primaryText';
        const String? expectedSecondaryText = null;
        final Map<String?, String> expectedQueryParams = <String?, String>{
          messageParam.name: expectedMessage,
          primaryTextParam.name: expectedPrimaryText,
          secondaryTextParam.name: il8n.generalCancel,
          titleParam.name: expectedTitle,
        };
        final DialogServiceImpl unit = createUnitToTest();
        when(mockNavigationService.push<DialogAction>(anyInstanceOf<AlertDialogViewRoute>()))
            .thenAnswer((_) async => null);

        await unit.confirm(
          message: expectedMessage,
          title: expectedTitle,
          primaryText: expectedPrimaryText,
          secondaryText: expectedSecondaryText,
        );

        verify(mockNavigationService.push(argThat(isA<AlertDialogViewRoute>()
                .having((AlertDialogViewRoute r) => r.rawQueryParams, 'rawQueryParams', expectedQueryParams))))
            .called(1);
      });
    });
  });
}
