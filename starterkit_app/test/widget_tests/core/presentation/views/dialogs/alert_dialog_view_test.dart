import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_router.gr.dart';
import 'package:starterkit_app/core/presentation/views/dialogs/alert_dialog_view.dart';
import 'package:starterkit_app/features/app/presentation/views/app.dart';

import '../../../../../widget_test_utils.dart';

void main() {
  group(AlertDialogView, () {
    setUp(() async {
      await setUpWidgetTest();
    });

    testGoldens(
      'should have title, messsage and primary action button when secondary text is null',
      (WidgetTester tester) async {
        const String expectedMessage = 'message';
        const String expectedTitle = 'title';
        const String expectedPrimaryText = 'primaryText';

        await tester.pumpWidget(
          App(
            initialRoute: AlertDialogViewRoute(
              message: expectedMessage,
              title: expectedTitle,
              primaryText: expectedPrimaryText,
              secondaryText: null,
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester.matchGolden('alert_dialog_view_title_message_and_primary_action_button');
        expect(find.text(expectedMessage), findsOneWidget);
        expect(find.text(expectedTitle), findsOneWidget);
        expect(find.text(expectedPrimaryText), findsOneWidget);
      },
    );

    testGoldens(
      'should have title, messsage and primary and secondary action buttons when shown',
      (WidgetTester tester) async {
        const String expectedMessage = 'message';
        const String expectedTitle = 'title';
        const String expectedPrimaryText = 'primaryText';
        const String expectedSecondaryText = 'secondaryText';

        await tester.pumpWidget(
          App(
            initialRoute: AlertDialogViewRoute(
              message: expectedMessage,
              title: expectedTitle,
              primaryText: expectedPrimaryText,
              secondaryText: expectedSecondaryText,
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester.matchGolden('alert_dialog_view_title_message_and_primary_and_secondary_action_buttons');
        expect(find.text(expectedMessage), findsOneWidget);
        expect(find.text(expectedTitle), findsOneWidget);
        expect(find.text(expectedPrimaryText), findsOneWidget);
        expect(find.text(expectedSecondaryText), findsOneWidget);
      },
    );
  });
}
