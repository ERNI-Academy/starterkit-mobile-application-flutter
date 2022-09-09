import 'package:erni_mobile/business/models/settings/language_entity.dart';
import 'package:erni_mobile/common/localization/generated/l10n.dart';
import 'package:erni_mobile/common/localization/localization.dart';
import 'package:erni_mobile/dependency_injection.dart';
import 'package:erni_mobile/domain/services/logging/navigation_logger.dart';
import 'package:erni_mobile/domain/services/platform/environment_config.dart';
import 'package:erni_mobile/domain/services/ui/navigation/navigation_service.dart';
import 'package:erni_mobile/domain/services/ui/navigation/route_generator.dart';
import 'package:erni_mobile/ui/resources/theme.dart';
import 'package:erni_mobile/ui/view_models/main/app_view_model.dart';
import 'package:erni_mobile/ui/views/main/splash_view.dart';
import 'package:erni_mobile/ui/views/view_mixin.dart';
import 'package:erni_mobile/ui/widgets/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/utils/responsive_utils.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class App extends StatelessWidget with ViewMixin<AppViewModel> {
  const App({Key? key, this.home}) : super(key: key);

  final Widget? home;

  @override
  Widget buildView(BuildContext context, AppViewModel viewModel) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: viewModel.currentTheme,
      builder: (context, currentTheme, child) {
        return ValueListenableBuilder<LanguageEntity>(
          valueListenable: viewModel.currentLanguage,
          builder: (context, currentLanguage, child) {
            return MaterialApp(
              builder: (context, child) => ResponsiveWrapper.builder(
                child,
                defaultScale: true,
                breakpoints: const [
                  ResponsiveBreakpoint.autoScale(480, name: MOBILE),
                  ResponsiveBreakpoint.autoScale(800, name: TABLET),
                  ResponsiveBreakpoint.resize(1000, name: DESKTOP),
                ],
                landscapePlatforms: const [
                  ResponsiveTargetPlatform.android,
                  ResponsiveTargetPlatform.iOS,
                  ResponsiveTargetPlatform.web,
                  ResponsiveTargetPlatform.windows,
                  ResponsiveTargetPlatform.macOS,
                ],
              ),
              onGenerateTitle: (context) => ServiceLocator.instance<EnvironmentConfig>().appName,
              theme: MaterialAppThemes.lightTheme,
              darkTheme: MaterialAppThemes.darkTheme,
              themeMode: currentTheme,
              debugShowCheckedModeBanner: false,
              navigatorKey: NavigationService.navigatorKey,
              navigatorObservers: [
                ServiceLocator.instance<NavigationLogger>(),
                NavigationService.navigationObserverRegistrar,
                SentryNavigatorObserver(),
              ],
              home: home ?? const SplashView(),
              onGenerateRoute: RouteGenerator.onGenerateRoute,
              localizationsDelegates: const [
                Il8n.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: currentLanguage.toLocale(),
              supportedLocales: Il8n.delegate.supportedLocales,
            );
          },
        );
      },
    );
  }
}
