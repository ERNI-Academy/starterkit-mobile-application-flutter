// ignore_for_file: prefer_void_to_null
// ignore_for_file: prefer-static-class

import 'dart:ui';

import 'package:erni_mobile/business/models/logging/app_log_object.dart';
import 'package:erni_mobile/common/localization/localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:mockito/mockito.dart';

Null anyInstanceOf<T>({String? named}) => argThat(isA<T>(), named: named);

Null captureAnyInstanceOf<T>({String? named}) => captureThat(isA<T>(), named: named);

Future<void> setupLocale([String langCode = 'en']) async {
  await Il8n.load(Locale(langCode));
}

Future<Isar> setupIsar() async {
  await Isar.initializeIsarCore(download: true);
  final isar = await Isar.open([AppLogObjectSchema]);
  await isar.writeTxn(() async {
    await isar.appLogObjects.clear();
  });

  return isar;
}
