import 'package:erni_mobile/common/localization/generated/l10n.dart';
import 'package:flutter/foundation.dart';

@immutable
class SideMenuModel {
  SideMenuModel({
    required this.type,
    required this.actionType,
    bool isSelected = false,
  }) {
    this.isSelected = ValueNotifier(isSelected);
  }

  final MenuType type;
  final MenuActionType actionType;
  late final ValueNotifier<bool> isSelected;

  String get text {
    switch (type) {
      case MenuType.about:
        return Il8n.current.menuAbout;
      case MenuType.settings:
        return Il8n.current.menuSettings;
    }
  }
}

enum MenuType { about, settings }

enum MenuActionType { navigatable, clickable }
