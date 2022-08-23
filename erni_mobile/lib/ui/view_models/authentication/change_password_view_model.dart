import 'package:erni_mobile/business/models/authentication/password/change_password_entity.dart';
import 'package:erni_mobile/business/models/authentication/password/set_password_model.dart';
import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/common/constants/settings_keys.dart';
import 'package:erni_mobile/common/exceptions/domain_exceptions.dart';
import 'package:erni_mobile/common/localization/localization.dart';
import 'package:erni_mobile/common/utils/extensions/function_extensions.dart';
import 'package:erni_mobile/domain/services/authentication/password/change_password_service.dart';
import 'package:erni_mobile/domain/services/platform/connectivity_service.dart';
import 'package:erni_mobile/domain/services/settings/settings_service.dart';
import 'package:erni_mobile/domain/services/ui/dialog_service.dart';
import 'package:erni_mobile/ui/validations/required_rule.dart';
import 'package:erni_mobile/ui/view_models/authentication/set_password_view_model.dart';
import 'package:erni_mobile_blueprint_core/navigation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:validation_notifier/validation_notifier.dart';

@injectable
class ChangePasswordViewModel extends SetPasswordViewModel {
  ChangePasswordViewModel(
    super.appLogger,
    this._connectivityService,
    this._navigationService,
    this._dialogService,
    this._changePasswordService,
    this._settingsService,
  );

  final ConnectivityService _connectivityService;
  final NavigationService _navigationService;
  final DialogService _dialogService;
  final ChangePasswordService _changePasswordService;
  final SettingsService _settingsService;

  final ValidationNotifier<String> oldPassword = ValidationNotifier(rules: const [RequiredRule()]);

  @protected
  @override
  Future<void> onSubmit() async {
    final oldPasswordValidation = oldPassword.validate();
    errorMessage.value = oldPasswordValidation.errorMessage ?? '';

    if (oldPasswordValidation.isValid) {
      await super.onSubmit();
    }
  }

  @protected
  @override
  Future<void> trySetPassword(SetPasswordModel model) async {
    await _tryChangePassword(oldPassword.value.validatedValue!, model.password, model.confirmPassword);
  }

  Future<void> _tryChangePassword(String oldPassword, String newPassword, String confirmPassword) async {
    final isConnected = await _connectivityService.isConnected(showAlert: true);

    if (!isConnected) {
      return;
    }

    try {
      final email = _settingsService.getValue<String>(SettingsKeys.userEmail);
      final entity = ChangePasswordEntity(
        email: email!,
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      await _dialogService.showLoading();
      await _changePasswordService.changePassword(entity);
      await _dialogService.dismiss();
      await _dialogService.alert(
        Il8n.current.dialogPasswordChangedMessage,
        title: Il8n.current.dialogPasswordChangedTitle,
      );
      await _navigationService.pop();
    } on AccountOldPasswordMismatchException {
      await _dialogService.dismiss();
      errorMessage.value = Il8n.current.changePasswordOldPasswordIncorrectError;
    } catch (err, st) {
      await _dialogService.dismiss();
      errorMessage.value = Il8n.current.changePasswordGenericError;
      appLogger.log(LogLevel.error, '${_tryChangePassword.name} failed', err, st);
    }
  }
}
