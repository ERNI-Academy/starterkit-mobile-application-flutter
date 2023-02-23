import 'package:auto_route/auto_route.dart';

export 'package:erni_mobile/business/services/ui/navigation/navigation_service_impl.dart';

abstract class NavigationService implements RootStackRouter {
  Future<void> pushToNewRoot(PageRouteInfo route, {OnNavigationFailure? onFailure});
}
