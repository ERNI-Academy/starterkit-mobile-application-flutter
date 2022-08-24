import 'package:erni_mobile/common/constants/route_names.dart';
import 'package:erni_mobile/common/constants/widget_keys.dart';
import 'package:erni_mobile/common/localization/localization.dart';
import 'package:erni_mobile/ui/resources/resources.dart';
import 'package:erni_mobile/ui/view_models/authentication/login_view_model.dart';
import 'package:erni_mobile/ui/widgets/widgets.dart';
import 'package:erni_mobile_core/mvvm.dart';
import 'package:injectable/injectable.dart';
import 'package:validation_notifier/validation_notifier.dart';

@Named(RouteNames.login)
@Injectable(as: Widget)
class LoginView extends StatelessWidget with ViewMixin<LoginViewModel> {
  LoginView() : super(key: const Key(RouteNames.login));

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSchemes.darkBlue,
      body: AdaptiveStatusBar(
        referenceColor: ColorSchemes.darkBlue,
        child: SafeArea(
          bottom: false,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: context.appTheme.rawDimensions.maxWidth),
              child: StickyFooterScrollView.explicit(
                footer: const _BottomGraphicsSection(),
                children: const [
                  Padding(
                    padding: EdgeInsets.only(top: 64),
                    child: AppBanner(),
                  ),
                  _MiddleFormSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MiddleFormSection extends StatelessWidget {
  const _MiddleFormSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 24, top: 64, right: 24),
      child: Padding(
        padding: context.appTheme.edgeInsets.containerPadding,
        child: SpacedColumn(
          mainAxisSize: MainAxisSize.min,
          spacing: 24,
          children: [
            Text(
              Il8n.of(context).loginTitle,
              style: context.materialTheme.textTheme.headlineSmall,
            ),
            _LoginFormSection(),
            Align(
              alignment: Alignment.centerRight,
              child: _LoginFormButtonsSection(),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginFormSection extends StatelessWidget with ChildViewMixin<LoginViewModel> {
  @override
  Widget buildView(BuildContext context) {
    return AutofillGroup(
      child: ValueListenableBuilder<String>(
        valueListenable: viewModel.errorMessage,
        builder: (context, errorMessage, child) {
          return SpacedColumn(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            spacing: 24,
            children: [
              if (errorMessage.isNotEmpty) FormErrorText(errorMessage),
              ValueListenableBuilder<ValidationResult<String>>(
                valueListenable: viewModel.email,
                builder: (context, email, child) {
                  return AppTextFormField(
                    key: WidgetKeys.loginEmailTextField,
                    initialValue: viewModel.email.valueToValidate,
                    labelText: Il8n.of(context).loginEmailLabel,
                    onChanged: viewModel.email.update,
                    autofillHints: const [AutofillHints.email],
                    textInputType: TextInputType.emailAddress,
                    hasError: email.hasError,
                  );
                },
              ),
              ValueListenableBuilder<ValidationResult<String>>(
                valueListenable: viewModel.password,
                builder: (context, password, child) {
                  return AppTextFormField(
                    key: WidgetKeys.loginPasswordTextField,
                    initialValue: viewModel.password.valueToValidate,
                    labelText: Il8n.of(context).loginPasswordLabel,
                    onChanged: viewModel.password.update,
                    autofillHints: const [AutofillHints.password],
                    isPassword: true,
                    hasError: password.hasError,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _LoginFormButtonsSection extends StatelessWidget with ChildViewMixin<LoginViewModel> {
  @override
  Widget buildView(BuildContext context) {
    return SpacedColumn(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      spacing: 24,
      children: [
        TextButton(
          key: WidgetKeys.loginForgotPasswordButton,
          onPressed: viewModel.forgotPasswordCommand,
          child: Text(Il8n.of(context).loginForgotPasswordLabel),
        ),
        ElevatedButton(
          key: WidgetKeys.loginButton,
          onPressed: viewModel.submitCommand,
          child: Text(Il8n.of(context).loginButtonLabel),
        ),
      ],
    );
  }
}

class _BottomGraphicsSection extends StatelessWidget {
  const _BottomGraphicsSection();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Assets.graphics.imIllustration.image(),
    );
  }
}
