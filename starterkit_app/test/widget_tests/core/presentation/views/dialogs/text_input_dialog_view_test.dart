import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_router.gr.dart';
import 'package:starterkit_app/core/presentation/views/dialogs/text_input_dialog_view.dart';
import 'package:starterkit_app/features/app/presentation/views/app.dart';

import '../../../../../widget_test_utils.dart';

void main() {
  group(TextInputDialogView, () {
    setUp(() async {
      await setUpWidgetTest();
    });

    testGoldens(
      'should have title, messsage, text form field, primary and secondary action button',
      (WidgetTester tester) async {
        const String expectedMessage = 'message';
        const String expectedTitle = 'title';
        const String expectedPrimaryText = 'primaryText';
        const String expectedSecondaryText = 'secondaryText';

        await tester.pumpWidget(
          App(
            initialRoute: TextInputDialogViewRoute(
              message: expectedMessage,
              title: expectedTitle,
              primaryText: expectedPrimaryText,
              secondaryText: expectedSecondaryText,
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester
            .matchGolden('text_input_dialog_view_title_message_text_form_field_primary_and_secondary_action_button');
        expect(find.text(expectedMessage), findsOneWidget);
        expect(find.text(expectedTitle), findsOneWidget);
        expect(find.text(expectedPrimaryText), findsOneWidget);
        expect(find.text(expectedSecondaryText), findsOneWidget);
        expect(find.byType(TextFormField), findsOneWidget);
      },
    );

    testGoldens('should set text form field text', (WidgetTester tester) async {
      const String expectedMessage = 'message';
      const String expectedTitle = 'title';
      const String expectedPrimaryText = 'primaryText';
      const String expectedSecondaryText = 'secondaryText';
      const String expectedText = 'text';

      await tester.pumpWidget(
        App(
          initialRoute: TextInputDialogViewRoute(
            message: expectedMessage,
            title: expectedTitle,
            primaryText: expectedPrimaryText,
            secondaryText: expectedSecondaryText,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField), expectedText);
      await tester.pumpAndSettle();

      await tester.matchGolden('text_input_dialog_view_text_form_field_text_set');
      expect(find.text(expectedText), findsOneWidget);
    });
  });
}
