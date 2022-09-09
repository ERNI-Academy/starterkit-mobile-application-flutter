import 'package:erni_mobile/business/models/ui/drawer_menu_model.dart';
import 'package:erni_mobile/business/services/ui/menu_provider_impl.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../unit_test_utils.dart';

void main() {
  group(MenuProviderImpl, () {
    late List<DrawerMenuModel> expectedMenus;

    setUp(() async {
      await setupLocale();
      expectedMenus = [
        DrawerMenuModel(type: MenuTypes.about, actionType: MenuActionTypes.navigatable),
        DrawerMenuModel(type: MenuTypes.settings, actionType: MenuActionTypes.navigatable),
      ];
    });

    MenuProviderImpl createUnit() => MenuProviderImpl();

    void areMenusEqual(DrawerMenuModel expected, DrawerMenuModel actual) {
      expect(expected.type, actual.type);
      expect(expected.actionType, actual.actionType);
      expect(expected.text, actual.text);
    }

    test('menus should return correct values when called', () {
      // Act
      final actualMenus = createUnit().menus;

      // Assert
      expect(actualMenus.length, expectedMenus.length);

      for (var i = 0; i < expectedMenus.length; i++) {
        final expectedMenu = expectedMenus[i];
        final actualMenu = actualMenus[i];
        areMenusEqual(expectedMenu, actualMenu);
      }
    });

    test('navigatableMenus should return correct values when called', () {
      // Arrange
      final expectedNavigatableMenus = expectedMenus.where((m) => m.actionType == MenuActionTypes.navigatable).toList();

      // Act
      final actualNavigatableMenus = createUnit().navigatableMenus;

      // Assert
      expect(actualNavigatableMenus.length, expectedNavigatableMenus.length);

      for (var i = 0; i < expectedNavigatableMenus.length; i++) {
        final expectedMenu = expectedNavigatableMenus[i];
        final actualMenu = actualNavigatableMenus[i];
        areMenusEqual(expectedMenu, actualMenu);
      }
    });

    test('currentMenu should return about menu as initial value when called', () {
      // Arrange
      final expectedCurrentMenu = DrawerMenuModel(
        type: MenuTypes.about,
        actionType: MenuActionTypes.navigatable,
        isSelected: true,
      );
      final unit = createUnit();

      // Assert
      areMenusEqual(unit.currentMenu, expectedCurrentMenu);
    });

    test('currentMenu should assign expected value when set', () {
      // Arrange
      final expectedCurrentMenu = DrawerMenuModel(
        type: MenuTypes.about,
        actionType: MenuActionTypes.navigatable,
      );

      // Act
      final unit = createUnit();
      unit.currentMenu = expectedCurrentMenu;

      // Assert
      areMenusEqual(unit.currentMenu, expectedCurrentMenu);
    });
  });
}
