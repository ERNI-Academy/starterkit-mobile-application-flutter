import 'package:erni_mobile/business/models/ui/drawer_menu_model.dart';
import 'package:erni_mobile/domain/services/ui/menu_provider.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: MenuProvider)
class MenuProviderImpl implements MenuProvider {
  MenuProviderImpl() {
    menus = List.unmodifiable(<DrawerMenuModel>[
      DrawerMenuModel(type: MenuTypes.about, actionType: MenuActionTypes.navigatable),
      DrawerMenuModel(type: MenuTypes.settings, actionType: MenuActionTypes.navigatable),
    ]);
    _currentMenu = menus.first;
    _currentMenu.isSelected.value = true;
  }

  late DrawerMenuModel _currentMenu;

  @override
  late final List<DrawerMenuModel> menus;

  @override
  List<DrawerMenuModel> get navigatableMenus =>
      List.unmodifiable(menus.where((m) => m.actionType == MenuActionTypes.navigatable));

  @override
  DrawerMenuModel get currentMenu => _currentMenu;

  @override
  set currentMenu(DrawerMenuModel newValue) {
    _currentMenu = newValue;
  }
}
