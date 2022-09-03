import 'dart:async';

import 'package:erni_mobile/domain/services/ui/navigation/navigation_parameter_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

typedef Queries = Map<String, String>;

abstract class NavigationService {
  static final navigatorKey = GlobalKey<NavigatorState>();

  String? get currentRoute;

  Future<bool> pop([Object? result]);

  void popToRoot();

  void popUntil(String routeName);

  Future<T?> push<T extends Object>(
    String routeName, {
    Object? parameter,
    Queries queries = const {},
    bool isFullScreenDialog = false,
  });

  Future<T?> pushAndRemoveUntil<T extends Object>(
    String routeName, {
    required String removeUntil,
    Object? parameter,
    Queries queries = const {},
    bool isFullScreenDialog = false,
  });

  Future<void> pushToNewRoot(
    String routeName, {
    Object? parameter,
    Queries queries = const {},
    bool isFullScreenDialog = false,
  });

  Future<T?> pushReplacement<T extends Object>(
    String routeName, {
    Object? parameter,
    Queries queries = const {},
    Object? result,
    bool isFullScreenDialog = false,
  });
}

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
      arguments: NavigationParameterWrapper(parameter, isFullScreenDialog: isFullScreenDialog),
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
      arguments: NavigationParameterWrapper(parameter, isFullScreenDialog: isFullScreenDialog),
    ) as T?;

    return result;
  }

  @override
  Future<void> pushToNewRoot(
    String routeName, {
    Object? parameter,
    Queries queries = const {},
    bool isFullScreenDialog = false,
  }) async {
    final routeUri = _createRouteUri(routeName, queries);

    // This future does not complete
    unawaited(
      _navigator.pushNamedAndRemoveUntil(
        routeUri.toString(),
        (_) => false,
        arguments: NavigationParameterWrapper(parameter, isRoot: true, isFullScreenDialog: isFullScreenDialog),
      ),
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
      arguments: NavigationParameterWrapper(parameter, isFullScreenDialog: isFullScreenDialog),
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