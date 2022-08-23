import 'package:erni_mobile/common/constants/regular_expressions.dart';
import 'package:erni_mobile/common/localization/localization.dart';
import 'package:validation_notifier/validation_notifier.dart';

class EmailFormatRule extends ValidationRule<String> {
  const EmailFormatRule();

  @override
  String get errorMessage => Il8n.current.validationInvalidEmailFormat;

  @override
  bool checkIsValid(String? value) => RegularExpressions.email.hasMatch(value ?? '');
}
