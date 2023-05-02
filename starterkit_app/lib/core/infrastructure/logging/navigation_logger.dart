import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/infrastructure/logging/logger.dart';

abstract class NavigationLogger implements NavigatorObserver {}

@LazySingleton(as: NavigationLogger)
class NavigationLoggerImpl extends RouteObserver<ModalRoute> implements NavigationLogger {
  final Logger _logger;

  NavigationLoggerImpl(this._logger) {
    _logger.logFor<NavigationLoggerImpl>();
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _logger.log(LogLevel.info, '${_getRoutePath(previousRoute)} === PUSHED ==> ${_getRoutePath(route)}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    _logger.log(LogLevel.info, '${_getRoutePath(previousRoute)} <== POPPED === ${_getRoutePath(route)}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _logger.log(LogLevel.info, '${_getRoutePath(oldRoute)} === REPLACED ==> ${_getRoutePath(newRoute)}');
  }

  static String _getRoutePath(Route? route) {
    final routeSettings = route?.settings;

    if (routeSettings is AutoRoutePage) {
      final routeData = routeSettings.routeData;

      return routeData.path;
    } else {
      return routeSettings?.name ?? '';
    }
  }
}
