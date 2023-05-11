import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:starterkit_app/core/dependency_injection.dart';
import 'package:starterkit_app/core/infrastructure/logging/navigation_logger.dart';
import 'package:starterkit_app/core/infrastructure/navigation/navigation_observer.dart';
import 'package:starterkit_app/core/infrastructure/navigation/navigation_service.dart';
import 'package:starterkit_app/core/presentation/views/view_mixin.dart';
import 'package:starterkit_app/features/app/presentation/view_models/app_view_model.dart';
import 'package:starterkit_app/shared/localization/localization.dart';

class App extends StatefulWidget {
  const App({super.key, this.initialRoute});

  final PageRouteInfo? initialRoute;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with ViewMixin<AppViewModel> {
  late final NavigationService _navigationService = ServiceLocator.instance<NavigationService>();
  late final NavigationLogger _navigationLogger = ServiceLocator.instance<NavigationLogger>();

  @override
  Widget buildView(BuildContext context, AppViewModel viewModel) {
    return MaterialApp.router(
      routerDelegate: AutoRouterDelegate(
        _navigationService,
        navigatorObservers: () => [
          _navigationLogger,
          NavigationObserver.instance,
        ],
        initialRoutes: widget.initialRoute != null ? [widget.initialRoute!] : null,
      ),
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      routeInformationParser: _navigationService.defaultRouteParser(),
      localizationsDelegates: const [
        Il8n.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: Il8n.delegate.supportedLocales,
    );
  }
}
