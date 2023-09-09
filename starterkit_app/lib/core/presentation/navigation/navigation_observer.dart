import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

abstract interface class NavigationObserver implements RouteObserver<ModalRoute<Object?>> {}

@LazySingleton(as: NavigationObserver)
class NavigationObserverImpl extends RouteObserver<ModalRoute<Object?>> implements NavigationObserver {}
