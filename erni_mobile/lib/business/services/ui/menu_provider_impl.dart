import 'package:erni_mobile/business/models/ui/side_menu_model.dart';
import 'package:erni_mobile/domain/services/ui/menu_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: MenuProvider)
class MenuProviderImpl implements MenuProvider {
  @override
  final Iterable<SideMenuModel> menus = List.unmodifiable(<SideMenuModel>[
    SideMenuModel(type: MenuType.about, actionType: MenuActionType.navigatable, isSelected: true),
    SideMenuModel(type: MenuType.settings, actionType: MenuActionType.navigatable),
  ]);

  @override
  late final ValueNotifier<SideMenuModel> currentMenu = ValueNotifier<SideMenuModel>(menus.first);

  @override
  Iterable<SideMenuModel> get navigatableMenus =>
      List.unmodifiable(menus.where((m) => m.actionType == MenuActionType.navigatable));
}
