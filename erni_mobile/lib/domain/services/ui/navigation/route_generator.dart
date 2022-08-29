import 'package:erni_mobile/domain/services/ui/navigation/navigation_parameter_wrapper.dart';
import 'package:erni_mobile/domain/services/ui/navigation/view_locator.dart';
import 'package:erni_mobile/ui/widgets/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:page_transition/page_transition.dart';

abstract class RouteGenerator {
  Route<Object> onGenerateRoute(RouteSettings settings);
}

@LazySingleton(as: RouteGenerator)
class RouteGeneratorImpl implements RouteGenerator {
  RouteGeneratorImpl(this._viewLocator);

  final ViewLocator _viewLocator;

  @override
  Route<Object> onGenerateRoute(RouteSettings settings) {
    final routeName = settings.name;

    if (routeName == null) {
      throw StateError('routeName is null');
    }

    final isRouteRegistered = _viewLocator.isViewRegistered(routeName);

    if (isRouteRegistered) {
      final view = _viewLocator.getView(routeName);
      final navigationParameter = settings.arguments as NavigationParameterWrapper?;
      final newSettings = RouteSettings(name: routeName, arguments: navigationParameter?.argument);

      if (navigationParameter?.isRoot == true) {
        return _createPageTransition(view, newSettings);
      }

      return MaterialPageRoute<Object>(
        builder: (context) => view,
        settings: newSettings,
        fullscreenDialog: navigationParameter?.isFullScreenDialog ?? false,
      );
    }

    return _createPageTransition(const RouteNotFound(), const RouteSettings(name: 'not-found'));
  }

  static PageTransition<Object> _createPageTransition(Widget view, RouteSettings? settings) {
    return PageTransition<Object>(
      child: view,
      type: PageTransitionType.fade,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 250),
      settings: settings,
    );
  }
}
