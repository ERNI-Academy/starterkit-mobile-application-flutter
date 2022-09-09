// coverage:ignore-file

import 'package:erni_mobile/dependency_injection.dart';
import 'package:flutter/widgets.dart';

abstract class ViewLocator {
  static bool isViewRegistered(String name) {
    final viewUri = Uri.parse(name);
    final viewPath = viewUri.path;
    final isViewRegistered = ServiceLocator.instance.isRegistered<Widget>(instanceName: viewPath);

    return isViewRegistered;
  }

  static Widget getView(String name) {
    final viewUri = Uri.parse(name);
    final viewPath = viewUri.path;
    final view = ServiceLocator.instance<Widget>(instanceName: viewPath);

    return view;
  }
}
