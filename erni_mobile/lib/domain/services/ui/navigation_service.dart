import 'dart:async';

import 'package:flutter/material.dart';

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
