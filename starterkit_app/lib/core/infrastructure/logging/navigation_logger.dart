import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/infrastructure/logging/logger.dart';

abstract interface class NavigationLogger implements NavigatorObserver {}

@LazySingleton(as: NavigationLogger)
class NavigationLoggerImpl extends RouteObserver<ModalRoute<Object?>> implements NavigationLogger {
  final Logger _logger;

  NavigationLoggerImpl(this._logger) {
    _logger.logFor<NavigationLoggerImpl>();
  }

  @override
  void didPush(covariant Route<Object?> route, covariant Route<Object?>? previousRoute) {
    super.didPush(route, previousRoute);
    _logger.log(LogLevel.info, '${_getRoutePath(previousRoute)} === PUSHED ==> ${_getRoutePath(route)}');
  }

  @override
  void didPop(covariant Route<Object?> route, covariant Route<Object?>? previousRoute) {
    super.didPop(route, previousRoute);
    _logger.log(LogLevel.info, '${_getRoutePath(previousRoute)} <== POPPED === ${_getRoutePath(route)}');
  }

  @override
  void didReplace({covariant Route<Object?>? newRoute, covariant Route<Object?>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _logger.log(LogLevel.info, '${_getRoutePath(oldRoute)} === REPLACED ==> ${_getRoutePath(newRoute)}');
  }

  static String _getRoutePath(Route<Object?>? route) {
    final routeSettings = route?.settings;

    if (routeSettings is AutoRoutePage) {
      final routeData = routeSettings.routeData;

      return routeData.path;
    }

    return routeSettings?.name ?? '';
  }
}
