import 'package:erni_mobile/common/constants/route_names.dart';
import 'package:erni_mobile/common/constants/widget_keys.dart';
import 'package:erni_mobile/common/localization/localization.dart';
import 'package:erni_mobile/ui/views/authentication/login_view.dart';
import 'package:erni_mobile/ui/views/main/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../widget_test_utils.dart';

void main() {
  group(LoginView, () {
    setUp(() async {
      await setupWidgetTest();
    });

    Future<void> expectToFindAllWidgets() async {
      await expectLater(find.byKey(WidgetKeys.loginEmailTextField), findsOneWidget);
      await expectLater(find.byKey(WidgetKeys.loginPasswordTextField), findsOneWidget);
      await expectLater(find.byKey(WidgetKeys.loginButton), findsOneWidget);
      await expectLater(find.byKey(WidgetKeys.loginForgotPasswordButton), findsOneWidget);
    }

    testGoldens('should show initial state when called', (tester) async {
      // Arrange
      await tester.pumpWidget(App(home: LoginView()));
      await tester.pumpAndSettle();

      // Assert
      await expectToFindAllWidgets();
      await multiScreenGoldenForPlatform(tester, 'login_view_shows_initial_state');
    });

    testGoldens('should show error message when email and password are empty', (tester) async {
      // Arrange
      await tester.pumpWidget(App(home: LoginView()));
      await tester.pumpAndSettle();

      // Act
      await tester.enterText(find.byKey(WidgetKeys.loginEmailTextField), '');
      await tester.enterText(find.byKey(WidgetKeys.loginPasswordTextField), '');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.byKey(WidgetKeys.loginButton));
      await tester.tap(find.byKey(WidgetKeys.loginButton));
      await tester.pumpAndSettle();

      // Assert
      await expectToFindAllWidgets();
      await expectLater(find.text(Il8n.current.validationRequiredField), findsOneWidget);
      await multiScreenGoldenForPlatform(tester, 'login_view_shows_error_message_when_email_and_password_are_empty');
    });

    testGoldens('should navigate to forgot password view when forgot password button was tapped', (tester) async {
      // Arrange
      await tester.pumpWidget(App(home: LoginView()));
      await tester.pumpAndSettle();

      // Act
      await tester.tap(find.byKey(WidgetKeys.loginForgotPasswordButton));
      await tester.pumpAndSettle();

      // Assert
      await expectLater(find.byKey(const Key(RouteNames.forgotPassword)), findsOneWidget);
      await multiScreenGoldenForPlatform(
        tester,
        'login_view_navigate_to_forgot_password_view_when_forgot_password_button_was_tapped',
      );
    });
  });
}
