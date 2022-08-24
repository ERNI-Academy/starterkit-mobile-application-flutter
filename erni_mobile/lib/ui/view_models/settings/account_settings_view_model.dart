import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/business/models/ui/confirm_dialog_response.dart';
import 'package:erni_mobile/common/constants/messaging_channels.dart';
import 'package:erni_mobile/common/constants/route_names.dart';
import 'package:erni_mobile/common/localization/localization.dart';
import 'package:erni_mobile/common/utils/extensions/function_extensions.dart';
import 'package:erni_mobile/domain/services/authentication/logout/logout_service.dart';
import 'package:erni_mobile/domain/services/logging/app_logger.dart';
import 'package:erni_mobile/domain/services/platform/connectivity_service.dart';
import 'package:erni_mobile/domain/services/ui/dialog_service.dart';
import 'package:erni_mobile_core/mvvm.dart';
import 'package:erni_mobile_core/navigation.dart';
import 'package:erni_mobile_core/utils.dart';
import 'package:injectable/injectable.dart';

@injectable
class AccountSettingsViewModel extends ViewModel {
  AccountSettingsViewModel(
    this._logger,
    this._navigationService,
    this._dialogService,
    this._connectivityService,
    this._messagingCenter,
    this._logoutService,
  ) {
    _logger.logFor(this);
  }

  final AppLogger _logger;
  final NavigationService _navigationService;
  final DialogService _dialogService;
  final ConnectivityService _connectivityService;
  final MessagingCenter _messagingCenter;
  final LogoutService _logoutService;

  late final AsyncRelayCommand changePasswordCommand = AsyncRelayCommand.withoutParam(_onChangePassword);

  late final AsyncRelayCommand deleteAccountCommand = AsyncRelayCommand.withoutParam(_onDeleteAccount);

  Future<void> _onChangePassword() async {
    await _navigationService.push(RouteNames.changePassword);
  }

  Future<void> _onDeleteAccount() async {
    if (await _confirmDeleteAccount()) {
      await _tryDeleteAccount();
    }
  }

  Future<bool> _confirmDeleteAccount() async {
    final confirmResult = await _dialogService.confirm(
      Il8n.current.settingsDeleteAccountDialogMessage,
      title: Il8n.current.settingsDeleteAccountDialogTitle,
      ok: Il8n.current.settingsDeleteAccountDialogOk,
    );

    return confirmResult == ConfirmDialogResponse.confirmed;
  }

  Future<void> _tryDeleteAccount() async {
    final isConnected = await _connectivityService.isConnected(showAlert: true);

    if (!isConnected) {
      return;
    }

    try {
      await _dialogService.showLoading();
      _logoutService.logout();
      _messagingCenter.send(channel: MessagingChannels.loggedOut);

      await _dialogService.dismiss();
      await _navigationService.pushToNewRoot(RouteNames.login);
    } catch (err, st) {
      _logger.log(LogLevel.error, '${_tryDeleteAccount.name} failed', err, st);
    }
  }
}
