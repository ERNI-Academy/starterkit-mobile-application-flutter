import 'package:flutter/widgets.dart';

abstract class NavigationObserverRegistrar implements RouteObserver<ModalRoute> {
  static NavigationObserverRegistrar? _instance;

  static NavigationObserverRegistrar get instance => _instance ??= _NavigationObserverRegistrarImpl();
}

class _NavigationObserverRegistrarImpl extends RouteObserver<ModalRoute> implements NavigationObserverRegistrar {}
