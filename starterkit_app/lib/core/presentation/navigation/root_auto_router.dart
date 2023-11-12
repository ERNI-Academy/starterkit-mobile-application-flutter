// coverage:ignore-file

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/presentation/navigation/custom_dialog_route.dart';
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
      CustomDialogRoute(page: AlertDialogViewRoute.page, path: '/dialogs/alert'),
      AutoRoute(page: PostsViewRoute.page, path: '/'),
      AutoRoute(page: PostDetailsViewRoute.page, path: '/posts/:postId'),
    ];
  }
}
