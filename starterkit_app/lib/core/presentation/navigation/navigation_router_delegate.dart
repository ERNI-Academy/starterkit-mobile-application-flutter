import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_logger.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_observer.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_router.dart';

@lazySingleton
class NavigationRouterDelegate extends AutoRouterDelegate {
  NavigationRouterDelegate(
    NavigationRouter super.controller,
    NavigationLogger logger,
    NavigationObserver observer,
  ) : super(
          navigatorObservers: () => <NavigatorObserver>[
            logger,
            observer,
          ],
        );
}
