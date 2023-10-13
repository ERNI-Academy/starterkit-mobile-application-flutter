// coverage:ignore-file

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/presentation/navigation/root_auto_router.gr.dart';

abstract interface class RootAutoRouter implements StackRouter {
  RouteInformationParser<Object> get routeInformationParser;
}

@LazySingleton(as: RootAutoRouter)
@AutoRouterConfig(replaceInRouteName: 'View,ViewRoute')
class RootAutoRouterImpl extends $RootAutoRouterImpl implements RootAutoRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  RouteInformationParser<Object> get routeInformationParser => root.defaultRouteParser();

  @override
  List<AutoRoute> get routes {
    return <AutoRoute>[
      AutoRoute(page: PostsViewRoute.page, path: '/'),
      AutoRoute(page: PostDetailsViewRoute.page, path: '/posts/:postId'),
      CustomRoute(
        page: AlertDialogViewRoute.page,
        barrierColor: Colors.black.withOpacity(0.5),
        barrierDismissible: false,
        transitionsBuilder: dialogTransitionBuilder,
        durationInMilliseconds: 300,
        reverseDurationInMilliseconds: 300,
        opaque: false,
        fullscreenDialog: true,
      ),
    ];
  }

  Widget dialogTransitionBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
      ),
      child: child,
    );
  }
}
