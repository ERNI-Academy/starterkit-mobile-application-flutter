// coverage:ignore-file

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:erni_mobile/dependency_injection.dart';
import 'package:injectable/injectable.dart';

@module
abstract class PlatformModule {
  @lazySingleton
  @running
  Connectivity getConnectivity() => Connectivity();
}
