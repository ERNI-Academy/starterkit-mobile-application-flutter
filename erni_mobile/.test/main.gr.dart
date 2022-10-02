// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'main.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    AViewRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const AView(),
      );
    },
    BViewRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<BViewRouteArgs>(
          orElse: () => BViewRouteArgs(
                name: queryParams.optString('name'),
                id: queryParams.optString('id'),
                other: queryParams.get('other'),
              ));
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: BView(
          name: args.name,
          id: args.id,
          other: args.other,
        ),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/a',
          fullMatch: true,
        ),
        RouteConfig(
          AViewRoute.name,
          path: '/a',
        ),
        RouteConfig(
          BViewRoute.name,
          path: '/b',
        ),
      ];
}

/// generated route for
/// [AView]
class AViewRoute extends PageRouteInfo<void> {
  const AViewRoute()
      : super(
          AViewRoute.name,
          path: '/a',
        );

  static const String name = 'AViewRoute';
}

/// generated route for
/// [BView]
class BViewRoute extends PageRouteInfo<BViewRouteArgs> {
  BViewRoute({
    String? name,
    String? id,
    BViewParam? other,
  }) : super(
          BViewRoute.name,
          path: '/b',
          args: BViewRouteArgs(
            name: name,
            id: id,
            other: other,
          ),
          rawQueryParams: {
            'name': name,
            'id': id,
            'other': other,
          },
        );

  static const String name = 'BViewRoute';
}

class BViewRouteArgs {
  const BViewRouteArgs({
    this.name,
    this.id,
    this.other,
  });

  final String? name;

  final String? id;

  final BViewParam? other;

  @override
  String toString() {
    return 'BViewRouteArgs{name: $name, id: $id, other: $other}';
  }
}
