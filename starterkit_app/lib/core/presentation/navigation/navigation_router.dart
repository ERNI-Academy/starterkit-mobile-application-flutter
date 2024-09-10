// coverage:ignore-file

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/presentation/navigation/custom_dialog_route.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_router.gr.dart';

abstract interface class NavigationRouter implements StackRouter {
  RouteInformationParser<Object> get routeInformationParser;
}

@LazySingleton(as: NavigationRouter)
@AutoRouterConfig(replaceInRouteName: 'View,ViewRoute')
class NavigationRouterImpl extends RootStackRouter implements NavigationRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  RouteInformationParser<Object> get routeInformationParser => root.defaultRouteParser();

  @override
  List<AutoRoute> get routes {
    return <AutoRoute>[
      CustomDialogRoute(page: AlertDialogViewRoute.page, path: '/dialogs/alert'),
      CustomDialogRoute(page: TextInputDialogViewRoute.page, path: '/dialogs/text-input'),
      AutoRoute(page: PostsViewRoute.page, path: '/'),
      AutoRoute(page: PostDetailsViewRoute.page, path: '/posts/:postId'),
    ];
  }
}
