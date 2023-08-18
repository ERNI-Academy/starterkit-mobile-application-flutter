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

  NavigationServiceImpl(this._router);

  @override
  Future<T?> push<T extends Object?>(PageRouteInfo route, {OnNavigationFailure? onFailure}) async {
    final result = await _router.push(route, onFailure: onFailure);

    return result as T?;
  }

  @override
  Future<void> pushToNewRoot(PageRouteInfo route, {OnNavigationFailure? onFailure}) async {
    _router.popUntilRoot();
    await replace(route, onFailure: onFailure);
  }

  @override
  Future<T?> replace<T extends Object?>(PageRouteInfo route, {OnNavigationFailure? onFailure}) {
    unawaited(_router.replace(route, onFailure: onFailure)); // This future does not complete

    return Future.value();
  }
}