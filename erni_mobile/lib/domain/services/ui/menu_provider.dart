import 'package:erni_mobile/business/models/ui/side_menu_model.dart';
import 'package:flutter/foundation.dart';

abstract class MenuProvider {
  Iterable<SideMenuModel> get menus;

  Iterable<SideMenuModel> get navigatableMenus;

  ValueNotifier<SideMenuModel> get currentMenu;
}
