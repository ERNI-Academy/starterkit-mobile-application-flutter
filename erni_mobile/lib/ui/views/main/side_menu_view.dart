// coverage:ignore-file

import 'package:erni_mobile/business/models/ui/drawer_menu_model.dart';
import 'package:erni_mobile/ui/view_models/main/side_menu_view_model.dart';
import 'package:erni_mobile/ui/views/view_mixin.dart';
import 'package:erni_mobile/ui/widgets/widgets.dart';

class SideMenuView extends StatelessWidget with ViewMixin<SideMenuViewModel> {
  SideMenuView({required this.navigatableMenuSelected, Key? key}) : super(key: key);

  final void Function(DrawerMenuModel) navigatableMenuSelected;

  @override
  Widget buildView(BuildContext context, SideMenuViewModel viewModel) {
    return AdaptiveStatusBar(
      referenceColor: context.materialTheme.colorScheme.surface,
      child: Drawer(
        child: Column(
          children: [
            Flexible(
              child: ListView(
                children: viewModel.menus.map(
                  (m) {
                    return _MenuTile(
                      menu: m,
                      onTap: () => _onMenuTileTap(m, viewModel.menuTapCommand),
                    );
                  },
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onMenuTileTap(DrawerMenuModel menu, Future<bool?> Function(DrawerMenuModel) onTap) async {
    final shouldNavigate = await onTap(menu) ?? false;

    if (shouldNavigate) {
      navigatableMenuSelected(menu);
    }
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({required this.menu, required this.onTap});

  final DrawerMenuModel menu;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: menu.isSelected,
      builder: (context, isSelected, child) {
        return ListTile(
          selected: isSelected,
          selectedTileColor: context.materialTheme.colorScheme.primary.withOpacity(0.2),
          title: Text(menu.text),
          onTap: onTap,
        );
      },
    );
  }
}
