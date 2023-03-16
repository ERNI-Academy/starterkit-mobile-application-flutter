// coverage:ignore-file

// ignore_for_file: prefer_const_constructors

import 'package:erni_mobile/business/models/ui/side_menu_model.dart';
import 'package:erni_mobile/domain/ui/views/view_mixin.dart';
import 'package:erni_mobile/ui/view_models/main/side_menu_view_model.dart';
import 'package:erni_mobile/ui/widgets/widgets.dart';

class SideMenuView extends StatelessWidget with ViewMixin<SideMenuViewModel> {
  const SideMenuView({super.key});

  @override
  Widget buildView(BuildContext context, SideMenuViewModel viewModel) {
    return AdaptiveStatusBar(
      referenceColor: context.materialTheme.colorScheme.surface,
      child: Drawer(
        child: Column(
          children: [
            Flexible(
              child: ListView(
                children: [
                  ...viewModel.menus.map(
                    (m) {
                      return _MenuTile(
                        menu: m,
                        onTap: viewModel.onMenuTapped,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({required this.menu, required this.onTap});

  final SideMenuModel menu;
  final void Function(SideMenuModel) onTap;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: menu.isSelected,
      builder: (context, isSelected, child) {
        return ListTile(
          selected: isSelected,
          selectedTileColor: context.materialTheme.colorScheme.primary.withOpacity(0.2),
          title: Text(menu.text),
          onTap: () => onTap(menu),
        );
      },
    );
  }
}
