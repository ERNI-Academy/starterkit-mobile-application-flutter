import 'package:flutter/widgets.dart';

class NavigationObserver extends RouteObserver<ModalRoute<Object?>> {
  static final NavigationObserver instance = NavigationObserver._();

  NavigationObserver._();
}
