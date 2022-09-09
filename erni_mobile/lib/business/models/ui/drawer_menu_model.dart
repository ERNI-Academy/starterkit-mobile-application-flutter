import 'package:erni_mobile/common/localization/generated/l10n.dart';
import 'package:flutter/foundation.dart';

@immutable
class DrawerMenuModel {
  DrawerMenuModel({
    required this.type,
    required this.actionType,
    bool isSelected = false,
  }) {
    this.isSelected = ValueNotifier(isSelected);
  }

  final MenuTypes type;
  final MenuActionTypes actionType;
  late final ValueNotifier<bool> isSelected;

  String get text {
    switch (type) {
      case MenuTypes.about:
        return Il8n.current.menuAbout;
      case MenuTypes.settings:
        return Il8n.current.menuSettings;
    }
  }
}

enum MenuTypes { about, settings }

enum MenuActionTypes { navigatable, clickable }
