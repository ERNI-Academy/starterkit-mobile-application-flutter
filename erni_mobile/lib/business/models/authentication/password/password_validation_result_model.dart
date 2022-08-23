import 'package:validation_notifier/validation_notifier.dart';

class PasswordValidationResultModel {
  PasswordValidationResultModel({
    required this.isValid,
    required this.passwordValidation,
    required this.confirmPasswordValidation,
  });

  final bool isValid;
  final ValidationResult<String> passwordValidation;
  final ValidationResult<String> confirmPasswordValidation;
}
