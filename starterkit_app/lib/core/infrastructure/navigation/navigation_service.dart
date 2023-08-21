// coverage:ignore-file

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

abstract interface class NavigationService {
  Future<T?> push<T extends Object?>(PageRouteInfo route, {OnNavigationFailure? onFailure});

  Future<void> pushToNewRoot(PageRouteInfo route, {OnNavigationFailure? onFailure});

  Future<T?> replace<T extends Object?>(PageRouteInfo route, {OnNavigationFailure? onFailure});
}

@LazySingleton(as: NavigationService)
class NavigationServiceImpl implements NavigationService {
  final RootStackRouter _router;

  const NavigationServiceImpl(this._router);

  @override
  Future<T?> push<T extends Object?>(PageRouteInfo route, {OnNavigationFailure? onFailure}) async {
    return await _router.push(route, onFailure: onFailure) as T?;
  }

  @override
  Future<void> pushToNewRoot(PageRouteInfo route, {OnNavigationFailure? onFailure}) async {
    _router.popUntilRoot();
    final Object? _ = await replace(route, onFailure: onFailure);
  }

  @override
  Future<T?> replace<T extends Object?>(PageRouteInfo route, {OnNavigationFailure? onFailure}) {
    unawaited(_router.replace(route, onFailure: onFailure)); // This future does not complete

    return Future<T?>.value();
  }
}
