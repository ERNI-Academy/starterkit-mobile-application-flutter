import 'package:erni_mobile/common/constants/regular_expressions.dart';
import 'package:erni_mobile/common/localization/localization.dart';
import 'package:validation_notifier/validation_notifier.dart';

class PasswordStrengthRule extends ValidationRule<String> {
  const PasswordStrengthRule();

  @override
  String get errorMessage => Il8n.current.validationInvalidPasswordStrength;

  @override
  bool checkIsValid(String? value) => RegularExpressions.password.hasMatch(value ?? '');
}
