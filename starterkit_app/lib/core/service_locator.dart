// coverage:ignore-file

import 'package:get_it/get_it.dart';

abstract interface class ServiceLocator {
  static T get<T extends Object>() {
    return GetIt.instance.get<T>();
  }
}
