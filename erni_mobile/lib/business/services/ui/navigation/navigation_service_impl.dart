import 'dart:async';

import 'package:erni_mobile/business/models/ui/navigation_options.dart';
import 'package:erni_mobile/domain/services/ui/navigation_service.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: NavigationService)
class NavigationServiceImpl implements NavigationService {
  NavigatorState get _navigator {
    final navigatorState = NavigationService.navigatorKey.currentState;

    if (navigatorState == null) {
      throw StateError('NavigatorState is null');
    }

    return navigatorState;
  }

  @override
  String? get currentRoute => ModalRoute.of(_navigator.context)?.settings.name;

  @override
  Future<bool> pop([Object? result]) => _navigator.maybePop(result);

  @override
  void popToRoot() {
    _navigator.popUntil((route) => route.isFirst);
  }

  @override
  void popUntil(String routeName) {
    _navigator.popUntil(ModalRoute.withName(routeName));
  }

  @override
  Future<T?> push<T extends Object>(
    String routeName, {
    Object? parameter,
    Queries queries = const {},
    bool isFullScreenDialog = false,
  }) async {
    final routeUri = _createRouteUri(routeName, queries);
    final result = await _navigator.pushNamed(
      routeUri.toString(),
      arguments: NavigationOptions(parameter, isFullScreenDialog: isFullScreenDialog),
    ) as T?;

    return result;
  }

  @override
  Future<T?> pushAndRemoveUntil<T extends Object>(
    String routeName, {
    required String removeUntil,
    Object? parameter,
    Queries queries = const {},
    bool isFullScreenDialog = false,
  }) async {
    final routeUri = _createRouteUri(routeName, queries);
    final result = await _navigator.pushNamedAndRemoveUntil(
      routeUri.toString(),
      ModalRoute.withName(removeUntil),
      arguments: NavigationOptions(parameter, isFullScreenDialog: isFullScreenDialog),
    ) as T?;

    return result;
  }

  @override
  void pushToNewRoot(
    String routeName, {
    Object? parameter,
    Queries queries = const {},
    bool isFullScreenDialog = false,
  }) {
    final routeUri = _createRouteUri(routeName, queries);

    _navigator.pushNamedAndRemoveUntil(
      routeUri.toString(),
      (_) => false,
      arguments: NavigationOptions(parameter, isRoot: true, isFullScreenDialog: isFullScreenDialog),
    );
  }

  @override
  Future<T?> pushReplacement<T extends Object>(
    String routeName, {
    Object? parameter,
    Queries queries = const {},
    Object? result,
    bool isFullScreenDialog = false,
  }) async {
    final routeUri = _createRouteUri(routeName, queries);
    final navigationResult = await _navigator.pushReplacementNamed(
      routeUri.toString(),
      arguments: NavigationOptions(parameter, isFullScreenDialog: isFullScreenDialog),
      result: result,
    ) as T?;

    return navigationResult;
  }

  static Uri _createRouteUri(String routeName, Queries queries) {
    final originalUri = Uri.parse(routeName);

    if (queries.isNotEmpty) {
      final newQueries = <String, String>{}
        ..addAll(originalUri.queryParameters)
        ..addAll(queries);

      return Uri(path: originalUri.path, queryParameters: newQueries);
    }

    return originalUri;
  }
}
