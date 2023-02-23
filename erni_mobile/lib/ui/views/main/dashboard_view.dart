// coverage:ignore-file

import 'package:auto_route/auto_route.dart';
import 'package:erni_mobile/domain/services/ui/navigation/navigation_service.dart';
import 'package:erni_mobile/domain/ui/views/view_mixin.dart';
import 'package:erni_mobile/ui/view_models/main/dashboard_view_model.dart';
import 'package:erni_mobile/ui/views/main/side_menu_view.dart';
import 'package:erni_mobile/ui/widgets/widgets.dart';

class DashboardView extends StatelessWidget with ViewMixin<DashboardViewModel> {
  const DashboardView() : super(key: const Key(DashboardViewRoute.name));

  @override
  Widget buildView(BuildContext context, DashboardViewModel viewModel) {
    // AutoTabsRouter(
    //   routes: const [
    //     AboutViewRoute(),
    //     SettingsViewRoute(),
    //   ],
    //   lazyLoad: true,
    //   builder: (context, child, animation) {
    //     final tabsRouter = AutoTabsRouter.of(context);

    //     return Scaffold(
    //       body: child,
    //       bottomNavigationBar: BottomNavigationBar(
    //         selectedIconTheme: IconThemeData(color: context.materialTheme.colorScheme.primary),
    //         unselectedIconTheme: IconThemeData(color: context.materialTheme.colorScheme.onBackground),
    //         selectedItemColor: context.materialTheme.colorScheme.primary,
    //         unselectedItemColor: context.materialTheme.colorScheme.onBackground,
    //         type: BottomNavigationBarType.fixed,
    //         showSelectedLabels: false,
    //         showUnselectedLabels: false,
    //         currentIndex: tabsRouter.activeIndex,
    //         onTap: (index) => _onTap(context, index),
    //         items: _getBottomMenuItems(context),
    //       ),
    //     );
    //   },
    // );

    return AutoTabsRouter(
      routes: const [
        AboutViewRoute(),
        SettingsViewRoute(),
      ],
      lazyLoad: true,
      builder: (context, child, animation) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final isLandscape = constraints.minWidth >= constraints.minHeight;

            return Row(
              children: [
                if (isLandscape) const SideMenuView(),
                Expanded(
                  child: Scaffold(
                    backgroundColor: context.materialTheme.colorScheme.background,
                    body: child,
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
}
