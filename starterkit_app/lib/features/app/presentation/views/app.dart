import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:starterkit_app/common/localization/generated/l10n.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_logger.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_observer.dart';
import 'package:starterkit_app/core/presentation/navigation/navigation_router.dart';
import 'package:starterkit_app/core/presentation/views/view_model_builder.dart';
import 'package:starterkit_app/core/service_locator.dart';
import 'package:starterkit_app/features/app/presentation/view_models/app_view_model.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoViewModelBuilder<AppViewModel>(
      builder: (BuildContext context, AppViewModel viewModel) {
        return const _App();
      },
    );
  }
}

class _App extends StatefulWidget {
  const _App();

  @override
  State<_App> createState() => _AppState();
}

class _AppState extends State<_App> {
  final NavigationRouter _rootStackRouter = ServiceLocator.get<NavigationRouter>();
  final NavigationLogger _navigationLogger = ServiceLocator.get<NavigationLogger>();
  final NavigationObserver _navigationObserver = ServiceLocator.get<NavigationObserver>();

  @override
  void dispose() {
    _rootStackRouter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: _rootStackRouter.routeInformationParser,
      routerDelegate: AutoRouterDelegate(
        _rootStackRouter,
        navigatorObservers: () => <NavigatorObserver>[
          _navigationLogger,
          _navigationObserver,
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
}
