import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/business/models/ui/confirm_dialog_response.dart';
import 'package:erni_mobile/business/models/ui/drawer_menu_model.dart';
import 'package:erni_mobile/business/models/user/user_profile_entity.dart';
import 'package:erni_mobile/common/constants/messaging_channels.dart';
import 'package:erni_mobile/common/constants/route_names.dart';
import 'package:erni_mobile/common/localization/localization.dart';
import 'package:erni_mobile/common/utils/extensions/function_extensions.dart';
import 'package:erni_mobile/domain/services/authentication/logout/logout_service.dart';
import 'package:erni_mobile/domain/services/logging/app_logger.dart';
import 'package:erni_mobile/domain/services/platform/connectivity_service.dart';
import 'package:erni_mobile/domain/services/settings/settings_service.dart';
import 'package:erni_mobile/domain/services/ui/dialog_service.dart';
import 'package:erni_mobile/domain/services/ui/menu_provider.dart';
import 'package:erni_mobile/domain/services/user/profile/user_profile_service.dart';
import 'package:erni_mobile_blueprint_core/mvvm.dart';
import 'package:erni_mobile_blueprint_core/navigation.dart';
import 'package:erni_mobile_blueprint_core/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@injectable
class SideMenuViewModel extends ViewModel {
  SideMenuViewModel(
    this._navigationService,
    this._dialogService,
    this._connectivityService,
    this._messagingCenter,
    this._logger,
    this._menuProvider,
    this._userProfileService,
    this._settingsService,
    this._logoutService,
  ) {
    menus = _menuProvider.menus;
  }

  final NavigationService _navigationService;
  final DialogService _dialogService;
  final ConnectivityService _connectivityService;
  final MessagingCenter _messagingCenter;
  final AppLogger _logger;
  final MenuProvider _menuProvider;
  final UserProfileService _userProfileService;
  final SettingsService _settingsService;
  final LogoutService _logoutService;

  final ValueNotifier<UserProfileEntity> userProfile =
      ValueNotifier(const UserProfileEntity(id: 1, firstName: '', lastName: '', email: ''));

  late final List<DrawerMenuModel> menus;

  late final AsyncTwoWayCommand<DrawerMenuModel, bool> menuTapCommand = AsyncTwoWayCommand.withParam(_onMenuTapped);

  late final AsyncRelayCommand getUserProfileCommand = AsyncRelayCommand.withoutParam(_getUserProfile);

  DrawerMenuModel get currentMenu => menus.firstWhere((m) => m.type == _menuProvider.currentMenu.type);

  @override
  Future<void> onInitialize([Object? parameter, Queries queries = const {}]) async {
    await getUserProfileCommand();
  }

  Future<void> _getUserProfile() async {
    final isConnected = await _connectivityService.isConnected(showAlert: true);

    if (!isConnected) {
      return;
    }

    try {
      userProfile.value = await _userProfileService.getUserProfile(cached: true);
    } catch (err, st) {
      _logger.log(LogLevel.error, '${_getUserProfile.name} failed', err, st);
    }
  }

  Future<bool> _onMenuTapped(DrawerMenuModel? menu) async {
    if (menu == null) {
      return false;
    }

    switch (menu.actionType) {
      case MenuActionTypes.navigatable:
        await _handleNavigatableMenu(menu);
        return true;

      case MenuActionTypes.clickable:
        await _handleClickableMenu(menu.type);
        return false;
    }
  }

  Future<void> _handleNavigatableMenu(DrawerMenuModel menu) async {
    currentMenu.isSelected.value = false;
    menu.isSelected.value = true;
    _menuProvider.currentMenu = menu;
    await _navigationService.pop();
  }

  Future<void> _handleClickableMenu(MenuTypes type) async {
    switch (type) {
      case MenuTypes.logout:
        await _logout();
        break;

      default:
        break;
    }
  }

  Future<void> _logout() async {
    final confirmResult = await _dialogService.confirm(
      Il8n.current.menuLogoutDialogText,
      title: Il8n.current.menuLogoutDialogTitle,
      ok: Il8n.current.menuLogoutDialogOk,
    );

    if (confirmResult == ConfirmDialogResponse.confirmed) {
      _logoutService.logout();
      await _settingsService.deleteAll();
      await _navigationService.pushToNewRoot(RouteNames.login);
      _messagingCenter.send(channel: MessagingChannels.loggedOut);
    }
  }
}
