# Validation Rules

We can define custom validation rules by inheriting from [`ValidationRule`](https://pub.dev/documentation/validation_notifier/latest/validation_notifier/ValidationRule-class.html), which is part of the package [`validation_notifier`](https://pub.dev/packages/validation_notifier).


```dart
import 'package:validation_notifier/validation_notifier.dart';

class RequiredStringRule extends ValidationRule<String> {
  const RequiredStringRule();

  @override
  String get errorMessage => 'This field is required';

  @override
  bool checkIsValid(String? value) => value?.isNotEmpty ?? false;
}

class EmailFormatRule extends ValidationRule<String> {
  const EmailFormatRule();

  @override
  String get errorMessage => 'Invalid email format';

  @override
  bool checkIsValid(String? value) => RegularExpressions.emailRegex.hasMatch(value ?? '');
}
```

We can then use these validations in our view model:

```dart
import 'package:validation_notifier/validation_notifier.dart';

@injectable
class LoginViewModel extends ViewModel {
  LoginViewModel() {
    loginCommand = Command.createAsyncNoParamNoResult(_onLogin);
  }

  final ValidationNotifier<String> email = ValidationNotifier(rules: const [RequiredRule(), EmailFormatRule()]); // USE

  final ValidationNotifier<String> password = ValidationNotifier(rules: const [RequiredRule()]); // USE

  late final Command<void, void> loginCommand;

  Future<void> _onLogin() async {
    final emailValidation = email.validate();
    final passwordValidation = password.validate();
    final emailValue = emailValidation.validatedValue;
    final passwordValue = passwordValidation.validatedValue;

    if (emailValidation.isValid && passwordValidation.isValid) {
      // Do login
    }
  }
}
```