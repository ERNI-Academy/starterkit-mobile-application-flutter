// coverage:ignore-file

import 'package:erni_mobile/business/models/ui/side_menu_model.dart';
import 'package:erni_mobile/common/constants/route_names.dart';
import 'package:erni_mobile/common/localization/localization.dart';
import 'package:erni_mobile/domain/ui/views/view_mixin.dart';
import 'package:erni_mobile/ui/view_models/main/home_view_model.dart';
import 'package:erni_mobile/ui/views/main/about_view.dart';
import 'package:erni_mobile/ui/views/main/side_menu_view.dart';
import 'package:erni_mobile/ui/views/settings/settings_view.dart';
import 'package:erni_mobile/ui/widgets/widgets.dart';
import 'package:injectable/injectable.dart';

@Named(RouteNames.home)
@Injectable(as: Widget)
class HomeView extends StatelessWidget with ViewMixin<HomeViewModel> {
  HomeView() : super(key: const Key(RouteNames.home));

  late final Iterable<Widget> _menuWidgets;
  late final PageController _pageController;
  late final VoidCallback _selectedMenuIndexListener;

  @override
  HomeViewModel onCreateViewModel(BuildContext context) {
    final viewModel = super.onCreateViewModel(context);
    _pageController = PageController(initialPage: viewModel.selectedMenuIndex);
    _setMenuWidgets(viewModel.menus);

    viewModel.selectedMenu.addListener(
      _selectedMenuIndexListener = () => _pageController.jumpToPage(viewModel.selectedMenuIndex),
    );

    return viewModel;
  }

  @override
  void onDisposeViewModel(BuildContext context, HomeViewModel viewModel) {
    super.onDisposeViewModel(context, viewModel);
    viewModel.selectedMenu.removeListener(_selectedMenuIndexListener);
  }

  @override
  Widget buildView(BuildContext context, HomeViewModel viewModel) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLandscape = constraints.minWidth >= constraints.minHeight;

        return ValueListenableBuilder<SideMenuModel>(
          valueListenable: viewModel.selectedMenu,
          builder: (context, selectedMenu, child) {
            return Row(
              children: [
                if (isLandscape) const SideMenuView(),
                Expanded(
                  child: Scaffold(
                    appBar: AppBar(title: Text(selectedMenu.text)),
                    backgroundColor: context.materialTheme.colorScheme.background,
                    body: PageView.builder(
                      itemCount: _menuWidgets.length,
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => _menuWidgets.elementAt(index),
                    ),
                    drawer: isLandscape ? null : const SideMenuView(),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _setMenuWidgets(Iterable<SideMenuModel> menus) {
    _menuWidgets = menus.map((m) {
      Widget child;

      switch (m.type) {
        case MenuType.settings:
          child = const SettingsView();
          break;

        case MenuType.about:
          child = const AboutView();
          break;

        default:
          child = const _NotImplementedView();
          break;
      }

      return KeepAliveWidget(child: child);
    });
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
