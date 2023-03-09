import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:erni_mobile/common/constants/widget_keys.dart';
import 'package:erni_mobile/domain/services/ui/navigation/navigation_service.dart';
import 'package:erni_mobile/ui/views/main/about_view.dart';
import 'package:erni_mobile/ui/views/main/dashboard_view.dart';
import 'package:erni_mobile/ui/views/posts/posts_view.dart';
import 'package:erni_mobile/ui/views/settings/settings_view.dart';
import 'package:erni_mobile/ui/widgets/widgets.dart';
import 'package:injectable/injectable.dart';

part 'navigation_service_impl.gr.dart';

typedef GenericRoute<T extends Object> = AutoRoute<T>;

typedef ExplicitRoute<T extends Object> = CustomRoute<T>;

@LazySingleton(as: NavigationService)
@MaterialAutoRouter(
  routes: <AutoRoute>[
    GenericRoute(
      path: '/dashboard',
      page: DashboardView,
      initial: true,
      children: [
        RedirectRoute(path: '', redirectTo: 'posts'),
        ExplicitRoute(
          path: 'posts',
          page: PostsView,
          initial: true,
          transitionsBuilder: TransitionsBuilders.noTransition,
          durationInMilliseconds: 0,
        ),
        ExplicitRoute(
          path: 'about',
          page: AboutView,
          transitionsBuilder: TransitionsBuilders.noTransition,
          durationInMilliseconds: 0,
        ),
        ExplicitRoute(
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
  NavigationServiceImpl() : super(WidgetKeys.navigatorKey);

  static Route<T> bottomSheetRouteBuilder<T>(BuildContext _, Widget child, CustomPage<T> page) {
    return ModalBottomSheetRoute(
      settings: page,
      builder: (context) => child,
      isScrollControlled: true,
    );
  }

  static Route<T> dialogRouteBuilder<T>(BuildContext context, Widget child, CustomPage<T> page) {
    return DialogRoute(
      context: context,
      settings: page,
      builder: (context) => child,
    );
  }

  @override
  Future<T?> replace<T extends Object?>(PageRouteInfo route, {OnNavigationFailure? onFailure}) {
    // This future does not complete
    unawaited(super.replace(route, onFailure: onFailure));

    return Future.value();
  }

  @override
  Future<T?> push<T extends Object?>(PageRouteInfo route, {OnNavigationFailure? onFailure}) async {
    final result = await super.push(route, onFailure: onFailure);

    return result as T?;
  }

  @override
  Future<void> pushToNewRoot(PageRouteInfo route, {OnNavigationFailure? onFailure}) async {
    popUntilRoot();
    await replace(route, onFailure: onFailure);
  }
}
