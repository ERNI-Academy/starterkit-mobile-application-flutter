// coverage:ignore-file

import 'package:erni_mobile/domain/services/ui/initial_ui_configurator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: InitialUiConfigurator)
class InitialUiConfiguratorImpl implements InitialUiConfigurator {
  @override
  void configure() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}
