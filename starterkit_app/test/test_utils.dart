// ignore_for_file: prefer-static-class

import 'dart:ui';

import 'package:starterkit_app/shared/localization/localization.dart';

Future<Il8n> setupLocale([String langCode = 'en']) {
  return Il8n.load(Locale(langCode));
}
