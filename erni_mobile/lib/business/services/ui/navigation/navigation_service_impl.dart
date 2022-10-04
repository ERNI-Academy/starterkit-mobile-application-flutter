import 'package:auto_route/auto_route.dart';
import 'package:erni_mobile/domain/services/ui/navigation_service.dart';
import 'package:erni_mobile/ui/views/main/about_view.dart';
import 'package:erni_mobile/ui/views/main/dashboard_view.dart';
import 'package:erni_mobile/ui/views/main/splash_view.dart';
import 'package:erni_mobile/ui/views/settings/settings_view.dart';
import 'package:erni_mobile/ui/widgets/widgets.dart';
import 'package:injectable/injectable.dart';

part 'navigation_service_impl.gr.dart';

typedef ViewRoute<T extends Object> = AutoRoute<T>;

typedef CustomViewRoute<T extends Object> = CustomRoute<T>;

@LazySingleton(as: NavigationService)
@MaterialAutoRouter(
  routes: <AutoRoute>[
    ViewRoute(
      path: '/splash',
      page: SplashView,
      initial: true,
    ),
    ViewRoute(
      path: '/dashboard',
      page: DashboardView,
      children: [
        RedirectRoute(path: '', redirectTo: 'about'),
        CustomViewRoute(
          path: 'about',
          page: AboutView,
          initial: true,
          transitionsBuilder: TransitionsBuilders.noTransition,
          durationInMilliseconds: 0,
        ),
        CustomViewRoute(
          path: 'settings',
          page: SettingsView,
          transitionsBuilder: TransitionsBuilders.noTransition,
          durationInMilliseconds: 0,
        ),
      ],
    ),
  ],
)
class NavigationServiceImpl extends _$NavigationServiceImpl implements NavigationService {
  NavigationServiceImpl() : super(NavigationService.currentNavigatorKey);
}
