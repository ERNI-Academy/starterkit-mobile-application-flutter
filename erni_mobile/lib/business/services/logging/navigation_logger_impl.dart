import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/domain/services/logging/app_logger.dart';
import 'package:erni_mobile/domain/services/logging/navigation_logger.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: NavigationLogger)
class NavigationLoggerImpl extends NavigationLogger {
  NavigationLoggerImpl(this._logger) {
    _logger.logFor(this);
  }

  final AppLogger _logger;

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);

    final routeName = route.settings.name;

    if (routeName != null) {
      _logger.log(LogLevel.info, 'Pushed $routeName');
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);

    final routeName = route.settings.name;

    if (routeName != null) {
      _logger.log(LogLevel.info, 'Popped $routeName');
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);

    final routeName = newRoute?.settings.name;

    if (routeName != null) {
      _logger.log(LogLevel.info, 'Replaced with $routeName');
    }
  }
}
