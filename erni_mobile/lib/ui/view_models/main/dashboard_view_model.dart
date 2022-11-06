import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/business/models/ui/side_menu_model.dart';
import 'package:erni_mobile/domain/services/logging/app_logger.dart';
import 'package:erni_mobile/domain/services/ui/menu_provider.dart';
import 'package:erni_mobile/domain/ui/view_models/view_model.dart';
import 'package:erni_mobile/reflection.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@injectable
@reflectable
class DashboardViewModel extends ViewModel {
  DashboardViewModel(MenuProvider menuProvider, this._logger) {
    menus = menuProvider.navigatableMenus;
    selectedMenu = menuProvider.currentMenu;
    selectedMenu.addListener(_onMenuSelected);
    _logger.logFor(this);
  }

  final AppLogger _logger;

  late final Iterable<SideMenuModel> menus;

  late final ValueNotifier<SideMenuModel> selectedMenu;

  int get selectedMenuIndex => menus.toList().indexWhere((m) => m.type == selectedMenu.value.type);

  void _onMenuSelected() {
    _logger.log(LogLevel.info, 'Navigating to ${selectedMenu.value.type.name}');
  }
}
