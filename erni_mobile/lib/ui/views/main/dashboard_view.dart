// coverage:ignore-file

import 'package:auto_route/auto_route.dart';
import 'package:erni_mobile/business/models/ui/side_menu_model.dart';
import 'package:erni_mobile/domain/services/ui/navigation/navigation_service.dart';
import 'package:erni_mobile/domain/ui/views/view_mixin.dart';
import 'package:erni_mobile/ui/view_models/main/dashboard_view_model.dart';
import 'package:erni_mobile/ui/views/main/side_menu_view.dart';
import 'package:erni_mobile/ui/widgets/widgets.dart';

class DashboardView extends StatelessWidget with ViewMixin<DashboardViewModel> {
  DashboardView({@messageParam String? message}) : super(key: const Key(DashboardViewRoute.name));

  @override
  Widget buildView(BuildContext context, DashboardViewModel viewModel) {
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
                    body: const AutoRouter(inheritNavigatorObservers: false),
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
