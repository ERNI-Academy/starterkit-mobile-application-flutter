import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drift/drift.dart';
import 'package:erni_mobile/common/localization/localization.dart';
import 'package:erni_mobile/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/annotations.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widget_test_utils.mocks.dart';

@GenerateNiceMocks([
  MockSpec<SharedPreferences>(),
  MockSpec<FlutterSecureStorage>(),
  MockSpec<Connectivity>(),
])
Future<void> setupWidgetTest() async {
  await ServiceLocator.registerDependencies(forTesting: true);

  // We register mock 3rd party libraries
  ServiceLocator.instance.registerSingleton<SharedPreferences>(MockSharedPreferences());
  ServiceLocator.instance.registerSingleton<FlutterSecureStorage>(MockFlutterSecureStorage());
  ServiceLocator.instance.registerSingleton<Connectivity>(MockConnectivity());

  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  await Il8n.load(const Locale('en'));
  await loadAppFonts();
}

Future<void> multiScreenGoldenForPlatform(WidgetTester tester, String name) async {
  // Specify golden files to match depending on platform OS that rendered them
  // Related to https://github.com/flutter/flutter/issues/56383
  final platformGolden = join(Platform.operatingSystem, name);
  await multiScreenGolden(tester, platformGolden, devices: Devices.all);
}

extension WidgetTesterExtension on WidgetTester {
  Future<void> waitFor(Finder finder, {Duration timeout = const Duration(seconds: 30)}) async {
    bool timerDone = false;
    final timer = Timer(timeout, () => debugPrint('Pump until has timed out'));
    while (!timerDone) {
      await pump();

      final found = any(finder);
      if (found) {
        timerDone = true;
      }
    }
    timer.cancel();
  }
}

abstract class Devices {
  // Computed according to https://material.io/blog/device-metrics
  static const pixel6 = Device(size: Size(420.56, 934.58), name: 'pixel6_portrait');
  static const iphone8 = Device(size: Size(368.1, 654.72), name: 'iphone8_portrait');
  static final all = [pixel6, pixel6.landscape(), iphone8, iphone8.landscape()];
}

extension _DeviceExtension on Device {
  Device landscape() => Device(size: Size(size.height, size.width), name: name.replaceAll('portrait', 'landscape'));
}
