import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:starterkit_app/common/localization/generated/l10n.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_logger.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_observer.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_router.dart';
import 'package:starterkit_app/core/service_locator.dart';

class TestApp extends StatefulWidget {
  final PageRouteInfo? initialRoute;

  const TestApp({super.key, this.initialRoute});

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  final NavigationRouter _rootStackRouter = ServiceLocator.get<NavigationRouter>();
  final NavigationLogger _navigationLogger = ServiceLocator.get<NavigationLogger>();
  final NavigationObserver _navigationObserver = ServiceLocator.get<NavigationObserver>();
  late final AutoRouterDelegate _autoRouterDelegate = AutoRouterDelegate(
    _rootStackRouter,
    navigatorObservers: () => <NavigatorObserver>[
      _navigationLogger,
      _navigationObserver,
    ],
  );
  final Completer<void> _initialRouteCompleter = Completer<void>();

  @override
  void initState() {
    super.initState();
    unawaited(_setInitialRoute());
  }

  @override
  void dispose() {
    _rootStackRouter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initialRouteCompleter.future,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const SizedBox.shrink();
        }

        return MaterialApp.router(
          routeInformationParser: _rootStackRouter.routeInformationParser,
          routerDelegate: _autoRouterDelegate,
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Colors.blue,
          ),
          localizationsDelegates: const <LocalizationsDelegate<Object>>[
            Il8n.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: Il8n.delegate.supportedLocales,
        );
      },
    );
  }

  Future<void> _setInitialRoute() async {
    if (widget.initialRoute != null) {
      final RouteMatch<dynamic>? matchingRoute = _rootStackRouter.match(widget.initialRoute!);

      await _autoRouterDelegate.setInitialRoutePath(
        UrlState.fromSegments(<RouteMatch<dynamic>>[
          if (matchingRoute != null) matchingRoute,
        ]),
      );
    }

    _initialRouteCompleter.complete();
  }
}
