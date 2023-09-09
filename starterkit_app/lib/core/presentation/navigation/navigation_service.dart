import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/presentation/navigation/root_auto_router.dart';

abstract interface class NavigationService {
  Future<T?> push<T extends Object>(PageRouteInfo route, {OnNavigationFailure? onFailure});

  void pushToNewRoot(PageRouteInfo route, {OnNavigationFailure? onFailure});

  Future<T?> replace<T extends Object>(PageRouteInfo route, {OnNavigationFailure? onFailure});
}

@LazySingleton(as: NavigationService)
class NavigationServiceImpl implements NavigationService {
  final RootAutoRouter _router;

  const NavigationServiceImpl(this._router);

  @override
  Future<T?> push<T extends Object>(PageRouteInfo route, {OnNavigationFailure? onFailure}) async {
    final T? result = await _router.push(route, onFailure: onFailure) as T?;

    return result;
  }

  @override
  void pushToNewRoot(PageRouteInfo route, {OnNavigationFailure? onFailure}) {
    _router.popUntilRoot();
    unawaited(replace(route, onFailure: onFailure)); // This future does not complete
  }

  @override
  Future<T?> replace<T extends Object>(PageRouteInfo route, {OnNavigationFailure? onFailure}) async {
    final T? result = await _router.replace(route, onFailure: onFailure);

    return result;
  }
}
