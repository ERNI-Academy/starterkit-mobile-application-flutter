// coverage:ignore-file

import 'package:erni_mobile/business/models/authentication/password/password_criteria_status_model.dart';
import 'package:erni_mobile/common/localization/localization.dart';
import 'package:erni_mobile/ui/view_models/authentication/set_password_view_model.dart';
import 'package:erni_mobile/ui/widgets/widgets.dart';
import 'package:erni_mobile_blueprint_core/mvvm.dart';
import 'package:validation_notifier/validation_notifier.dart';

class SetPasswordView<T extends SetPasswordViewModel> extends StatelessWidget with ChildViewMixin<T> {
  SetPasswordView({
    required this.title,
    required this.submitLabel,
    this.additionalField,
    this.hasBanner = true,
    Key? key,
  }) : super(key: key);

  final String title;
  final String submitLabel;
  final Widget? additionalField;
  final bool hasBanner;

  @override
  Widget buildView(BuildContext context) {
    final fields = [
      if (additionalField != null) additionalField!,
      _PasswordCriteriaSection<T>(),
      ValueListenableBuilder<ValidationResult<String>>(
        valueListenable: viewModel.password,
        builder: (context, password, child) {
          return AppTextFormField(
            onChanged: viewModel.password.update,
            labelText: Il8n.of(context).passwordLabel,
            autofillHints: const [AutofillHints.newPassword],
            hasError: password.hasError,
            isPassword: true,
          );
        },
      ),
      ValueListenableBuilder<ValidationResult<String>>(
        valueListenable: viewModel.confirmPassword,
        builder: (context, confirmPassword, child) {
          return AppTextFormField(
            onChanged: viewModel.confirmPassword.update,
            labelText: Il8n.of(context).confirmPasswordLabel,
            autofillHints: const [AutofillHints.newPassword],
            hasError: confirmPassword.hasError,
            isPassword: true,
          );
        },
      ),
    ];

    if (hasBanner) {
      return BanneredFormScaffold<T>(
        title: title,
        submitLabel: submitLabel,
        fields: fields,
      );
    }

    return FormScaffold<T>(
      title: title,
      submitLabel: submitLabel,
      fields: fields,
    );
  }
}

class _PasswordCriteriaSection<T extends SetPasswordViewModel> extends StatelessWidget with ChildViewMixin<T> {
  _PasswordCriteriaSection({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    return ValueListenableBuilder<PasswordCriteriaStatusModel>(
      valueListenable: viewModel.passwordCriteriaStatus,
      builder: (context, status, child) {
        return SpacedColumn(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _PasswordCriteriaStatus(
              text: Il8n.of(context).setPasswordMinimumEightCharacters,
              isValid: status.isEightCharactersOrMore,
              didValidate: viewModel.didValidate,
            ),
            _PasswordCriteriaStatus(
              text: Il8n.of(context).setPasswordContainsNumbersAndLetters,
              isValid: status.containsNumberAndLetter,
              didValidate: viewModel.didValidate,
            ),
            _PasswordCriteriaStatus(
              text: Il8n.of(context).setPasswordOneUppercaseLetter,
              isValid: status.containsUppercaseLetter,
              didValidate: viewModel.didValidate,
            ),
            _PasswordCriteriaStatus(
              text: Il8n.of(context).setPasswordOneLowercaseLetter,
              isValid: status.containsLowercaseLetter,
              didValidate: viewModel.didValidate,
            ),
            _PasswordCriteriaStatus(
              text: Il8n.of(context).setPasswordOneSpecialCharacter,
              isValid: status.containsSpecialCharacter,
              didValidate: viewModel.didValidate,
            ),
          ],
        );
      },
    );
  }
}

class _PasswordCriteriaStatus extends StatelessWidget {
  const _PasswordCriteriaStatus({required this.text, required this.isValid, required this.didValidate});

  final String text;
  final bool isValid;
  final bool didValidate;

  @override
  Widget build(BuildContext context) {
    var effectiveColor = isValid ? const Color(0xff00965e) : const Color(0xff999999);
    effectiveColor = !isValid && didValidate ? context.materialTheme.colorScheme.error : effectiveColor;

    return SizedBox(
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              color: effectiveColor,
              fontWeight: isValid || (!isValid && didValidate) ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (isValid)
            Icon(
              Icons.check_circle,
              color: effectiveColor,
              size: 20,
            )
          else if (!isValid && didValidate)
            Icon(
              Icons.warning,
              color: effectiveColor,
              size: 20,
            ),
        ],
      ),
    );
  }
}
