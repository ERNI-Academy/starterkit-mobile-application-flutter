import 'package:erni_mobile/common/localization/localization.dart';
import 'package:validation_notifier/validation_notifier.dart';

class RequiredRule<T extends Object> extends ValidationRule<T> {
  const RequiredRule();

  @override
  String get errorMessage => Il8n.current.validationRequiredField;

  @override
  bool checkIsValid(T? value) {
    var isValid = value != null;

    if (value is String?) {
      final strValue = value as String?;
      isValid = strValue?.isNotEmpty ?? false;
    }

    return isValid;
  }
}
