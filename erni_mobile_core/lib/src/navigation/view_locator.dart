import 'package:erni_mobile_core/src/dependency_injection/service_locator.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

abstract class ViewLocator {
  bool isViewRegistered(String name);

  Widget getView(String name);
}

@LazySingleton(as: ViewLocator)
class ViewLocatorImpl implements ViewLocator {
  @override
  bool isViewRegistered(String name) {
    final viewUri = Uri.parse(name);
    final viewPath = viewUri.path;
    final isViewRegistered = ServiceLocator.instance.isRegistered<Widget>(instanceName: viewPath);

    return isViewRegistered;
  }

  @override
  Widget getView(String name) {
    final viewUri = Uri.parse(name);
    final viewPath = viewUri.path;
    final view = ServiceLocator.instance<Widget>(instanceName: viewPath);

    return view;
  }
}
