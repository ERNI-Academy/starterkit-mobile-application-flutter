import 'dart:async';

import 'package:erni_mobile/business/models/authentication/password/password_criteria_status_model.dart';
import 'package:erni_mobile/business/models/authentication/password/password_validation_result_model.dart';
import 'package:erni_mobile/business/models/authentication/password/set_password_model.dart';
import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/common/constants/regular_expressions.dart';
import 'package:erni_mobile/common/localization/localization.dart';
import 'package:erni_mobile/common/utils/converters/base64_converter.dart';
import 'package:erni_mobile/domain/services/logging/app_logger.dart';
import 'package:erni_mobile/ui/validations/password_strength_rule.dart';
import 'package:erni_mobile/ui/validations/required_rule.dart';
import 'package:erni_mobile/ui/view_models/form_view_model.dart';
import 'package:erni_mobile_core/navigation.dart';
import 'package:flutter/foundation.dart';
import 'package:validation_notifier/validation_notifier.dart';

abstract class SetPasswordViewModel<T extends Object> extends FormViewModel<T> {
  static const String resetCodeKey = 'cc';
  static const Base64Converter _base64Converter = Base64Converter();

  SetPasswordViewModel(this.appLogger) {
    appLogger.logFor(this);
  }

  late final StreamSubscription _streamSubscription;
  String? _code;
  bool _didValidate = false;

  final ValidationNotifier<String> password = ValidationNotifier(rules: const [RequiredRule(), PasswordStrengthRule()]);

  final ValidationNotifier<String> confirmPassword =
      ValidationNotifier(rules: const [RequiredRule(), PasswordStrengthRule()]);

  final ValueNotifier<PasswordCriteriaStatusModel> passwordCriteriaStatus =
      ValueNotifier(const PasswordCriteriaStatusModel());

  bool get didValidate => _didValidate;

  @protected
  final AppLogger appLogger;

  @override
  @mustCallSuper
  Future<void> onInitialize([T? parameter, Queries queries = const {}]) async {
    _streamSubscription = password.valueToValidateChanged.listen(_onPasswordChanged);
    _parseQueries(queries);
  }

  @override
  @mustCallSuper
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @protected
  @override
  Future<void> onSubmit() async {
    final validationResult = validatePasswords();
    _didValidate = true;

    if (validationResult.isValid) {
      await trySetPassword(
        SetPasswordModel(
          password: validationResult.passwordValidation.validatedValue!,
          confirmPassword: validationResult.confirmPasswordValidation.validatedValue!,
          code: _code,
        ),
      );
    }
  }

  @protected
  PasswordValidationResultModel validatePasswords() {
    _onPasswordChanged(password.valueToValidate);

    final passwordValidation = password.validate();
    final confirmPasswordValidation = confirmPassword.validate();
    final arePasswordsValid = passwordValidation.isValid;
    final arePasswordsEqual = passwordValidation.validatedValue == confirmPasswordValidation.validatedValue;

    String errorMessage = '';

    if (arePasswordsValid && !arePasswordsEqual) {
      errorMessage = Il8n.current.validationPasswordsNotEqual;
    } else if (!arePasswordsValid) {
      errorMessage = Il8n.current.validationPasswordsDoesNotMatchCriteria;
    }

    password.value = ValidationResult<String>.invalid(
      validatedValue: passwordValidation.validatedValue,
      errorMessage: errorMessage,
    );
    confirmPassword.value = ValidationResult<String>.invalid(
      validatedValue: confirmPasswordValidation.validatedValue,
      errorMessage: errorMessage,
    );

    final arePasswordsValidAndEqual = arePasswordsValid && arePasswordsEqual;

    return PasswordValidationResultModel(
      isValid: arePasswordsValidAndEqual,
      passwordValidation: password.value,
      confirmPasswordValidation: confirmPassword.value,
    );
  }

  @protected
  Future<void> trySetPassword(SetPasswordModel model);

  void _onPasswordChanged(String? event) {
    bool hasEightCharacters = false;
    bool containsNumberAndLetter = false;
    bool containsUppercaseLetter = false;
    bool containsLowercaseLetter = false;
    bool containsSpecialCharacter = false;

    if (event != null) {
      hasEightCharacters = event.length >= 8;
      containsNumberAndLetter = RegularExpressions.numberAndLetter.hasMatch(event);
      containsUppercaseLetter = RegularExpressions.uppercase.hasMatch(event);
      containsLowercaseLetter = RegularExpressions.lowercase.hasMatch(event);
      containsSpecialCharacter = RegularExpressions.specialChar.hasMatch(event);
    }

    passwordCriteriaStatus.value = PasswordCriteriaStatusModel(
      isEightCharactersOrMore: hasEightCharacters,
      containsNumberAndLetter: containsNumberAndLetter,
      containsUppercaseLetter: containsUppercaseLetter,
      containsLowercaseLetter: containsLowercaseLetter,
      containsSpecialCharacter: containsSpecialCharacter,
    );
  }

  void _parseQueries(Queries queries) {
    if (queries.containsKey(resetCodeKey)) {
      final encodedCode = queries[resetCodeKey]!;
      _code = _base64Converter.convert(encodedCode);
      appLogger.log(LogLevel.info, 'Confirmation code is $_code');
    }
  }
}
