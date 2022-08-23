// ignore_for_file: prefer_void_to_null

import 'dart:ui';

import 'package:erni_mobile/common/localization/localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

Null anyInstanceOf<T>({String? named}) => argThat(isA<T>(), named: named);

Null captureAnyInstanceOf<T>({String? named}) => captureThat(isA<T>(), named: named);

Future<void> setupLocale([String langCode = 'en']) async {
  await Il8n.load(Locale(langCode));
}
