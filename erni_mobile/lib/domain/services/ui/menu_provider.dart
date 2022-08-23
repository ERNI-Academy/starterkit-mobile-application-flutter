import 'package:erni_mobile/business/models/ui/drawer_menu_model.dart';

abstract class MenuProvider {
  List<DrawerMenuModel> get menus;

  List<DrawerMenuModel> get navigatableMenus;

  DrawerMenuModel get currentMenu;

  set currentMenu(DrawerMenuModel newValue);
}
