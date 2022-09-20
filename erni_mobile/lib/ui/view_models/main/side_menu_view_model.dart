import 'package:erni_mobile/business/models/ui/drawer_menu_model.dart';
import 'package:erni_mobile/domain/services/ui/menu_provider.dart';
import 'package:erni_mobile/domain/services/ui/navigation/navigation_service.dart';
import 'package:erni_mobile/domain/ui/view_models/view_model.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_command/commands.dart';

@injectable
class SideMenuViewModel extends ViewModel {
  SideMenuViewModel(this._navigationService, this._menuProvider);

  final NavigationService _navigationService;

  final MenuProvider _menuProvider;

  late final List<DrawerMenuModel> menus = _menuProvider.menus;

  late final AsyncTwoWayCommand<DrawerMenuModel, bool> menuTapCommand = AsyncTwoWayCommand.withParam(_onMenuTapped);

  DrawerMenuModel get currentMenu => menus.firstWhere((m) => m.type == _menuProvider.currentMenu.type);

  Future<bool> _onMenuTapped(DrawerMenuModel menu) async {
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
      default:
        break;
    }
  }
}
