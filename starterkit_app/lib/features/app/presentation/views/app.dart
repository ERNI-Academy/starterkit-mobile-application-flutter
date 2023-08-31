import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:starterkit_app/common/localization/generated/l10n.dart';
import 'package:starterkit_app/core/infrastructure/logging/navigation_logger.dart';
import 'package:starterkit_app/core/infrastructure/navigation/navigation_observer.dart';
import 'package:starterkit_app/core/presentation/views/view_mixin.dart';
import 'package:starterkit_app/core/service_locator.dart';
import 'package:starterkit_app/features/app/presentation/view_models/app_view_model.dart';

class App extends StatefulWidget {
  const App({super.key, this.initialRoute});

  final PageRouteInfo? initialRoute;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with ViewMixin<AppViewModel> {
  final RootStackRouter _navigationService = ServiceLocator.instance<RootStackRouter>();
  final NavigationLogger _navigationLogger = ServiceLocator.instance<NavigationLogger>();

  @override
  void dispose() {
    _navigationService.dispose();
    super.dispose();
  }

  @override
  Widget buildView(BuildContext context, AppViewModel viewModel) {
    return MaterialApp.router(
      routeInformationParser: _navigationService.defaultRouteParser(),
      routerDelegate: AutoRouterDelegate(
        _navigationService,
        initialRoutes: _getInitialRoutes(),
        navigatorObservers: () => <NavigatorObserver>[
          _navigationLogger,
          NavigationObserver.instance,
        ],
      ),
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
  }

  List<PageRouteInfo>? _getInitialRoutes() {
    final List<PageRouteInfo> initialRoutes = <PageRouteInfo>[];
    final PageRouteInfo? appInitialRoute = widget.initialRoute;

    if (appInitialRoute != null) {
      initialRoutes.add(appInitialRoute);
    }

    return initialRoutes.isEmpty ? null : initialRoutes;
  }
}
