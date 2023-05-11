import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/infrastructure/navigation/navigation_service.gr.dart';

export 'package:starterkit_app/core/infrastructure/navigation/navigation_service.gr.dart';

abstract interface class NavigationService implements RootStackRouter {
  Future<void> pushToNewRoot(PageRouteInfo route, {OnNavigationFailure? onFailure});
}

@LazySingleton(as: NavigationService)
@AutoRouterConfig(replaceInRouteName: 'View,ViewRoute')
class NavigationServiceImpl extends $NavigationServiceImpl implements NavigationService {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(page: PostsViewRoute.page, path: '/'),
      AutoRoute(page: PostDetailsViewRoute.page, path: '/posts/:post'),
    ];
  }

  @override
  Future<T?> replace<T extends Object?>(PageRouteInfo route, {OnNavigationFailure? onFailure}) {
    unawaited(super.replace(route, onFailure: onFailure)); // This future does not complete

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
