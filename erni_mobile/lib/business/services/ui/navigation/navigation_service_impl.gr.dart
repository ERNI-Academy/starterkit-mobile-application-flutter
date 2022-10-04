// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'navigation_service_impl.dart';

class _$NavigationServiceImpl extends RootStackRouter {
  _$NavigationServiceImpl([GlobalKey<NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    SplashViewRoute.name: (routeData) {
      return MaterialPageX<Object>(
        routeData: routeData,
        child: SplashView(),
      );
    },
    DashboardViewRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<DashboardViewRouteArgs>(
          orElse: () => DashboardViewRouteArgs(
              message: queryParams.optString('message')));
      return MaterialPageX<Object>(
        routeData: routeData,
        child: DashboardView(message: args.message),
      );
    },
    AboutViewRoute.name: (routeData) {
      return CustomPage<Object>(
        routeData: routeData,
        child: AboutView(),
        transitionsBuilder: TransitionsBuilders.noTransition,
        durationInMilliseconds: 0,
        opaque: true,
        barrierDismissible: false,
      );
    },
    SettingsViewRoute.name: (routeData) {
      return CustomPage<Object>(
        routeData: routeData,
        child: SettingsView(),
        transitionsBuilder: TransitionsBuilders.noTransition,
        durationInMilliseconds: 0,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/splash',
          fullMatch: true,
        ),
        RouteConfig(
          SplashViewRoute.name,
          path: '/splash',
        ),
        RouteConfig(
          DashboardViewRoute.name,
          path: '/dashboard',
          children: [
            RouteConfig(
              '#redirect',
              path: '',
              parent: DashboardViewRoute.name,
              redirectTo: 'about',
              fullMatch: true,
            ),
            RouteConfig(
              AboutViewRoute.name,
              path: 'about',
              parent: DashboardViewRoute.name,
            ),
            RouteConfig(
              SettingsViewRoute.name,
              path: 'settings',
              parent: DashboardViewRoute.name,
            ),
          ],
        ),
      ];
}

/// generated route for
/// [SplashView]
class SplashViewRoute extends PageRouteInfo<void> {
  const SplashViewRoute()
      : super(
          SplashViewRoute.name,
          path: '/splash',
        );

  static const String name = 'SplashViewRoute';
}

/// generated route for
/// [DashboardView]
class DashboardViewRoute extends PageRouteInfo<DashboardViewRouteArgs> {
  DashboardViewRoute({
    String? message,
    List<PageRouteInfo>? children,
  }) : super(
          DashboardViewRoute.name,
          path: '/dashboard',
          args: DashboardViewRouteArgs(message: message),
          rawQueryParams: {'message': message},
          initialChildren: children,
        );

  static const String name = 'DashboardViewRoute';
}

class DashboardViewRouteArgs {
  const DashboardViewRouteArgs({this.message});

  final String? message;

  @override
  String toString() {
    return 'DashboardViewRouteArgs{message: $message}';
  }
}

/// generated route for
/// [AboutView]
class AboutViewRoute extends PageRouteInfo<void> {
  const AboutViewRoute()
      : super(
          AboutViewRoute.name,
          path: 'about',
        );

  static const String name = 'AboutViewRoute';
}

/// generated route for
/// [SettingsView]
class SettingsViewRoute extends PageRouteInfo<void> {
  const SettingsViewRoute()
      : super(
          SettingsViewRoute.name,
          path: 'settings',
        );

  static const String name = 'SettingsViewRoute';
}
