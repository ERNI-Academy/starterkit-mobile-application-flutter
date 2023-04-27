import 'package:flutter/widgets.dart';

class NavigationObserver extends RouteObserver<ModalRoute> {
  static final NavigationObserver instance = NavigationObserver._();

  NavigationObserver._();
}
