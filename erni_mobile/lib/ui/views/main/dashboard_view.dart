// coverage:ignore-file

import 'package:auto_route/auto_route.dart';
import 'package:erni_mobile/business/models/ui/side_menu_model.dart';
import 'package:erni_mobile/domain/services/ui/navigation/navigation_service.dart';
import 'package:erni_mobile/domain/ui/views/view_mixin.dart';
import 'package:erni_mobile/ui/view_models/main/dashboard_view_model.dart';
import 'package:erni_mobile/ui/views/main/side_menu_view.dart';
import 'package:erni_mobile/ui/widgets/widgets.dart';

class DashboardView extends StatelessWidget with ViewMixin<DashboardViewModel> {
  const DashboardView() : super(key: const Key(DashboardViewRoute.name));

  @override
  Widget buildView(BuildContext context, DashboardViewModel viewModel) {
    return AutoTabsRouter(
      routes: const [
        PostsViewRoute(),
        AboutViewRoute(),
        SettingsViewRoute(),
      ],
      homeIndex: 0,
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
                    appBar: AppBar(
                      title: ValueListenableBuilder<SideMenuModel>(
                        valueListenable: viewModel.selectedMenu,
                        builder: (context, value, child) {
                          return Text(value.text);
                        },
                      ),
                    ),
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
