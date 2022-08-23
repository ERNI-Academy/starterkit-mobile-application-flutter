import 'package:erni_mobile/business/models/authentication/login/user_login_entity.dart';
import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/common/constants/route_names.dart';
import 'package:erni_mobile/common/exceptions/domain_exceptions.dart';
import 'package:erni_mobile/common/localization/localization.dart';
import 'package:erni_mobile/common/utils/extensions/function_extensions.dart';
import 'package:erni_mobile/domain/services/authentication/login/login_service.dart';
import 'package:erni_mobile/domain/services/logging/app_logger.dart';
import 'package:erni_mobile/domain/services/platform/connectivity_service.dart';
import 'package:erni_mobile/domain/services/ui/dialog_service.dart';
import 'package:erni_mobile/domain/services/user/verification/user_verification_checker.dart';
import 'package:erni_mobile/ui/validations/email_format_rule.dart';
import 'package:erni_mobile/ui/validations/required_rule.dart';
import 'package:erni_mobile/ui/view_models/form_view_model.dart';
import 'package:erni_mobile_blueprint_core/mvvm.dart';
import 'package:erni_mobile_blueprint_core/navigation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:validation_notifier/validation_notifier.dart';

@injectable
class LoginViewModel extends FormViewModel {
  LoginViewModel(
    this._logger,
    this._dialogService,
    this._navigationService,
    this._userVerificationChecker,
    this._loginService,
    this._connectivityService,
  ) {
    _logger.logFor(this);
  }

  final AppLogger _logger;
  final DialogService _dialogService;
  final NavigationService _navigationService;
  final ConnectivityService _connectivityService;
  final LoginService _loginService;
  final UserVerificationChecker _userVerificationChecker;

  final ValidationNotifier<String> email = ValidationNotifier(rules: const [RequiredRule(), EmailFormatRule()]);

  final ValidationNotifier<String> password = ValidationNotifier(rules: const [RequiredRule()]);

  late final AsyncRelayCommand forgotPasswordCommand = AsyncRelayCommand.withoutParam(_onForgotPassword);

  @protected
  @override
  Future<void> onSubmit() async {
    errorMessage.value = '';

    final emailValidation = email.validate();
    final passwordValidation = password.validate();

    errorMessage.value = emailValidation.errorMessage ?? passwordValidation.errorMessage ?? '';

    if (emailValidation.isValid && passwordValidation.isValid) {
      final emailValue = emailValidation.validatedValue;
      final passwordValue = passwordValidation.validatedValue;

      await _tryLogin(emailValue!, passwordValue!);
    }
  }

  Future<void> _tryLogin(String email, String password) async {
    final isConnected = await _connectivityService.isConnected(showAlert: true);

    if (!isConnected) {
      return;
    }

    try {
      final entity = UserLoginEntity(email: email, password: password);
      await _dialogService.showLoading();
      await _loginService.login(entity);
      await _dialogService.dismiss();

      if (_userVerificationChecker.isUserVerified) {
        await _navigationService.pushToNewRoot(RouteNames.home);
      } else {
        await _dialogService.dismiss();
        await _dialogService.alert(
          Il8n.current.dialogUserNotVerifiedMessage,
          title: Il8n.current.dialogUserNotVerifiedTitle,
        );
      }
    } on UserInvalidCredentials {
      await _dialogService.dismiss();
      errorMessage.value = Il8n.current.validationInvalidEmailOrPassword;
    } on AccountLockedException {
      await _dialogService.dismiss();
      errorMessage.value = Il8n.current.loginAccountLockedError;
    } catch (err, st) {
      _logger.log(LogLevel.error, '${_tryLogin.name} failed', err, st);
      await _dialogService.dismiss();
      await _dialogService.alert(Il8n.current.loginGenericError);
    }
  }

  Future<void> _onForgotPassword() async {
    await _navigationService.push(RouteNames.forgotPassword);
  }
}
