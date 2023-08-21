// ignore_for_file: prefer-static-class

import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:path/path.dart';
import 'package:starterkit_app/core/service_locator.dart';
import 'package:starterkit_app/main.reflectable.dart';

import 'test_utils.dart';

Future<void> setupWidgetTest() async {
  ServiceLocator.registerDependencies();
  initializeReflectable();
  await setupLocale();
  await loadAppFonts();
}

abstract final class Devices {
  // Computed according to https://material.io/blog/device-metrics
  static const Device pixel6 = Device(size: Size(420.56, 934.58), name: 'pixel6_portrait');
  static const Device iphone8 = Device(size: Size(368.1, 654.72), name: 'iphone8_portrait');
  static final List<Device> all = <Device>[pixel6, pixel6.landscape(), iphone8, iphone8.landscape()];
}

extension WidgetTesterExtension on WidgetTester {
  Future<void> waitFor(Finder finder, {Duration timeout = const Duration(seconds: 30)}) async {
    bool timerDone = false;
    final Timer timer = Timer(timeout, () => debugPrint('Pump until has timed out'));
    while (!timerDone) {
      await pump();

      final bool found = any(finder);
      if (found) {
        timerDone = true;
      }
    }
    timer.cancel();
  }

  Future<void> matchGolden(String name) async {
    // Specify golden files to match depending on platform OS that rendered them
    // See https://github.com/flutter/flutter/issues/56383
    final String platformGolden = join(Platform.operatingSystem, name);
    await multiScreenGolden(this, platformGolden, devices: Devices.all);
  }
}

extension _DeviceExtension on Device {
  Device landscape() => Device(size: Size(size.height, size.width), name: name.replaceAll('portrait', 'landscape'));
}
