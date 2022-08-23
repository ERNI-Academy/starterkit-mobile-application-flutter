import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/common/exceptions/domain_exceptions.dart';
import 'package:erni_mobile/common/localization/localization.dart';
import 'package:erni_mobile/common/utils/extensions/function_extensions.dart';
import 'package:erni_mobile/domain/services/authentication/password/forgot_password_service.dart';
import 'package:erni_mobile/domain/services/logging/app_logger.dart';
import 'package:erni_mobile/domain/services/platform/connectivity_service.dart';
import 'package:erni_mobile/domain/services/ui/dialog_service.dart';
import 'package:erni_mobile/ui/validations/email_format_rule.dart';
import 'package:erni_mobile/ui/validations/required_rule.dart';
import 'package:erni_mobile/ui/view_models/form_view_model.dart';
import 'package:injectable/injectable.dart';
import 'package:validation_notifier/validation_notifier.dart';

@injectable
class ForgotPasswordViewModel extends FormViewModel {
  ForgotPasswordViewModel(
    this._logger,
    this._dialogService,
    this._connectivityService,
    this._forgotPasswordService,
  ) {
    _logger.logFor(this);
  }

  final AppLogger _logger;
  final DialogService _dialogService;
  final ConnectivityService _connectivityService;
  final ForgotPasswordService _forgotPasswordService;

  final ValidationNotifier<String> email = ValidationNotifier(rules: const [RequiredRule(), EmailFormatRule()]);

  @override
  Future<void> onSubmit() async {
    errorMessage.value = '';

    final emailValidation = email.validate();

    errorMessage.value = emailValidation.errorMessage ?? '';

    if (emailValidation.isValid) {
      await _trySendResetLink(emailValidation.validatedValue!);
    }
  }

  Future<void> _trySendResetLink(String email) async {
    final isConnected = await _connectivityService.isConnected(showAlert: true);

    if (!isConnected) {
      return;
    }

    try {
      await _dialogService.showLoading();
      await _forgotPasswordService.forgotPassword(email);
      await _dialogService.dismiss();
      await _dialogService.alert(
        Il8n.current.forgotPasswordEmailSentMessage,
        title: Il8n.current.forgotPasswordEmailSentTitle,
      );
    } on UserNotFoundException {
      await _dialogService.dismiss();
      this.email.value = ValidationResult.invalid(errorMessage: Il8n.current.forgotPasswordUserNotFound);
      errorMessage.value = Il8n.current.forgotPasswordUserNotFound;
    } on AccountMaximumResetPasswordAttemptException {
      await _dialogService.dismiss();
      this.email.value = ValidationResult.invalid(errorMessage: Il8n.current.forgotPasswordMaximumAttemptExceeded);
      errorMessage.value = Il8n.current.forgotPasswordMaximumAttemptExceeded;
    } catch (e, st) {
      _logger.log(LogLevel.error, '${_trySendResetLink.name} failed', e, st);
      await _dialogService.dismiss();
      await _dialogService.alert(Il8n.current.forgotPasswordGenericError);
    }
  }
}
