// coverage:ignore-file

import 'package:erni_mobile/business/models/ui/drawer_menu_model.dart';
import 'package:erni_mobile/common/constants/route_names.dart';
import 'package:erni_mobile/common/localization/localization.dart';
import 'package:erni_mobile/ui/view_models/main/home_view_model.dart';
import 'package:erni_mobile/ui/views/main/about_view.dart';
import 'package:erni_mobile/ui/views/main/side_menu_view.dart';
import 'package:erni_mobile/ui/views/settings/settings_view.dart';
import 'package:erni_mobile/ui/widgets/widgets.dart';
import 'package:erni_mobile_core/mvvm.dart';
import 'package:injectable/injectable.dart';

@Named(RouteNames.home)
@Injectable(as: Widget)
class HomeView extends StatelessWidget with ViewMixin<HomeViewModel> {
  HomeView() : super(key: const Key(RouteNames.home));

  late final List<Widget> _menuWidgets;
  late final PageController _pageController;

  @override
  HomeViewModel onCreateViewModel(BuildContext context) {
    final viewModel = super.onCreateViewModel(context);
    _pageController = PageController(initialPage: viewModel.selectedMenuIndex);
    _setMenuWidgets(viewModel.menus);

    return viewModel;
  }

  @override
  Widget buildView(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLandscape = constraints.minWidth >= constraints.minHeight;
        final sideMenu = SideMenuView(navigatableMenuSelected: _onNavigatableMenuSelected);

        return ValueListenableBuilder<DrawerMenuModel>(
          valueListenable: viewModel.selectedMenu,
          builder: (context, selectedMenu, child) {
            return Row(
              children: [
                if (isLandscape) sideMenu,
                Expanded(
                  child: Scaffold(
                    appBar: AppBar(title: Text(selectedMenu.text)),
                    backgroundColor: context.materialTheme.colorScheme.background,
                    body: PageView.builder(
                      itemCount: _menuWidgets.length,
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => _menuWidgets[index],
                    ),
                    drawer: isLandscape ? null : sideMenu,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _onNavigatableMenuSelected(DrawerMenuModel menu) {
    viewModel.navigatableMenuSelectedCommand(menu);
    _pageController.jumpToPage(viewModel.selectedMenuIndex);
  }

  void _setMenuWidgets(List<DrawerMenuModel> menus) {
    _menuWidgets = menus.map((m) {
      Widget child;

      switch (m.type) {
        case MenuTypes.settings:
          child = SettingsView();
          break;

        case MenuTypes.about:
          child = const AboutView();
          break;

        default:
          child = const _NotImplementedView();
          break;
      }

      return KeepAliveWidget(child: child);
    }).toList();
  }
}

class _NotImplementedView extends StatelessWidget {
  const _NotImplementedView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(Il8n.of(context).featureNotImplemented),
    );
  }
}
