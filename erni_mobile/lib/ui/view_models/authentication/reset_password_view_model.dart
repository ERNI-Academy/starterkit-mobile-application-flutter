import 'package:erni_mobile/business/models/authentication/password/reset_password_entity.dart';
import 'package:erni_mobile/business/models/authentication/password/set_password_model.dart';
import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/common/exceptions/domain_exceptions.dart';
import 'package:erni_mobile/common/localization/localization.dart';
import 'package:erni_mobile/common/utils/extensions/function_extensions.dart';
import 'package:erni_mobile/domain/services/authentication/password/reset_password_service.dart';
import 'package:erni_mobile/domain/services/platform/connectivity_service.dart';
import 'package:erni_mobile/domain/services/ui/dialog_service.dart';
import 'package:erni_mobile/ui/view_models/authentication/set_password_view_model.dart';
import 'package:erni_mobile_blueprint_core/navigation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

@injectable
class ResetPasswordViewModel extends SetPasswordViewModel {
  ResetPasswordViewModel(
    super.appLogger,
    this._navigationService,
    this._dialogService,
    this._connectivityService,
    this._resetPasswordService,
  );

  final NavigationService _navigationService;
  final DialogService _dialogService;
  final ConnectivityService _connectivityService;
  final ResetPasswordService _resetPasswordService;

  @protected
  @override
  Future<void> trySetPassword(SetPasswordModel model) async {
    final isConnected = await _connectivityService.isConnected(showAlert: true);

    if (!isConnected) {
      return;
    }

    try {
      final entity = ResetPasswordEntity(
        confirmationCode: model.code!,
        newPassword: model.password,
        confirmPassword: model.confirmPassword,
      );
      await _dialogService.showLoading();
      await _resetPasswordService.resetPassword(entity);
      await _dialogService.dismiss();
      await _dialogService.alert(
        Il8n.current.dialogPasswordChangedMessage,
        title: Il8n.current.dialogPasswordChangedTitle,
      );
      _navigationService.popToRoot();
    } on LinkUsedOrExpiredException {
      await _dialogService.dismiss();
      errorMessage.value = Il8n.current.resetPasswordLinkUsedOrExpiredError;
    } catch (err, st) {
      appLogger.log(LogLevel.error, '${trySetPassword.name} failed', err, st);
      await _dialogService.dismiss();
      await _dialogService.alert(Il8n.current.resetPasswordGenericError);
    }
  }
}
