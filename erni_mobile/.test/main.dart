import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:reflectable/mirrors.dart';
import 'package:test_app/main.reflectable.dart';
import 'package:test_app/view_model.dart';

part 'main.gr.dart';

abstract class RouteNames {
  static const String a = '/a';
  static const String b = '/b';
}

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: AView, initial: true, path: RouteNames.a),
    AutoRoute(page: BView, path: RouteNames.b),
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {}

void main() {
  initializeReflectable();
  runApp(App());
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key) {
    navigatorKey = appRouter.navigatorKey;
  }

  static final appRouter = AppRouter();
  static late final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
      title: 'AutoRoute Example',
    );
  }
}

class AView extends StatelessWidget {
  const AView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('A')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final result = await NavigationService.push(
                BViewRoute(name: 'John Doe', id: '123456', other: BViewParam()));
            log(result);
          },
          child: const Text('Go to B'),
        ),
      ),
    );
  }
}

class BView extends StatelessWidget with View<BViewModel> {
  BView(
      {@nameParam String? name,
      @idParam String? id,
      @otherParam BViewParam? other})
      : super(key: const Key(RouteNames.b));

  @override
  final BViewModel viewModel = BViewModel();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('B')),
      body: Center(
        child: ElevatedButton(
          onPressed: viewModel.goBack,
          child: const Text('Go back to A'),
        ),
      ),
    );
  }
}

class NavigationService {
  static BuildContext get _context => App.navigatorKey.currentState!.context;

  static Future<T?> push<T>(PageRouteInfo route) async {
    final result = await _context.router.push(route);

    return result as T?;
  }

  static Future<bool> pop<T>([T? result]) async {
    return _context.router.pop(result);
  }
}

abstract class View<T extends ViewModel> {
  T get viewModel;

  @mustCallSuper
  Widget build(BuildContext context) {
    final route = context.routeData;
    final instanceMirror = reflector.reflect(viewModel);
    final typeMirror = reflector.reflectType(T) as ClassMirror;
    route.queryParams.rawMap.forEach((key, value) {
      final declaration = typeMirror.declarations[key];
      if (declaration != null &&
          declaration.metadata
              .any((element) => element is QueryParam && element.name == key)) {
        instanceMirror.invokeSetter(key, value);
      }
    });

    viewModel.onInitialize(parameters: route.queryParams);

    return buildView(context);
  }

  Widget buildView(BuildContext context);
}
