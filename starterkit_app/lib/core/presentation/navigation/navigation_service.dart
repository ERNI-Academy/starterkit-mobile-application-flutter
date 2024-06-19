import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_router.dart';

@lazySingleton
class NavigationService {
  final NavigationRouter _router;

  NavigationService(this._router);

  Future<T?> push<T extends Object>(PageRouteInfo route) async {
    final T? result = await _router.push(route) as T?;
    return result;
  }

  void pushToNewRoot(PageRouteInfo route) {
    _router.popUntilRoot();
    unawaited(replace(route)); // This future does not complete
  }

  Future<T?> replace<T extends Object>(PageRouteInfo route) async {
    final T? result = await _router.replace(route);
    return result;
  }

  Future<bool> pop<T extends Object>([T? result]) async {
    final bool didPop = await _router.maybePop(result);
    return didPop;
  }
}
