import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/business/models/ui/drawer_menu_model.dart';
import 'package:erni_mobile/domain/services/logging/app_logger.dart';
import 'package:erni_mobile/domain/services/ui/menu_provider.dart';
import 'package:erni_mobile/ui/view_models/view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_command/commands.dart';

@injectable
class HomeViewModel extends ViewModel {
  HomeViewModel(MenuProvider menuProvider, this._logger) {
    menus = menuProvider.navigatableMenus;
    selectedMenu = ValueNotifier(menuProvider.currentMenu);
    _logger.logFor(this);
  }

  final AppLogger _logger;

  late final RelayCommand<DrawerMenuModel> navigatableMenuSelectedCommand = RelayCommand.withParam(_onMenuSelected);

  late final List<DrawerMenuModel> menus;

  late final ValueNotifier<DrawerMenuModel> selectedMenu;

  int get selectedMenuIndex => menus.indexWhere((m) => m.type == selectedMenu.value.type);

  void _onMenuSelected(DrawerMenuModel menu) {
    _logger.log(LogLevel.info, 'Navigating to ${menu.type.name}');
    selectedMenu.value = menu;
  }
}
