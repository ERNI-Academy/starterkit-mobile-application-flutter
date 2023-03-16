import 'package:erni_mobile/business/models/ui/side_menu_model.dart';
import 'package:erni_mobile/domain/services/ui/menu_provider.dart';
import 'package:erni_mobile/domain/services/ui/navigation/navigation_service.dart';
import 'package:erni_mobile/domain/ui/view_models/view_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class SideMenuViewModel extends ViewModel {
  final NavigationService _navigationService;
  final MenuProvider _menuProvider;

  SideMenuViewModel(this._navigationService, this._menuProvider);

  late final Iterable<SideMenuModel> menus = _menuProvider.menus;

  Future<void> onMenuTapped(SideMenuModel menu) async {
    switch (menu.actionType) {
      case MenuActionType.navigatable:
        await _handleNavigatableMenu(menu);
        break;
      case MenuActionType.clickable:
        _handleClickableMenu(menu.type);
        break;
    }
  }

  Future<void> _handleNavigatableMenu(SideMenuModel menu) async {
    _menuProvider.currentMenu.value.isSelected.value = false;
    menu.isSelected.value = true;
    _menuProvider.currentMenu.value = menu;

    switch (menu.type) {
      case MenuType.posts:
        await _navigationService.navigate(const PostsViewRoute());
        break;
      case MenuType.about:
        await _navigationService.navigate(const AboutViewRoute());
        break;
      case MenuType.settings:
        await _navigationService.navigate(const SettingsViewRoute());
        break;
    }

    await _navigationService.pop();
  }

  void _handleClickableMenu(MenuType type) {
    switch (type) {
      default:
        break;
    }
  }
}
