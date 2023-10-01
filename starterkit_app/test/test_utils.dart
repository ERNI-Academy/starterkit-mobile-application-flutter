// ignore_for_file: prefer-static-class

import 'dart:io';
import 'dart:ui';

import 'package:path/path.dart';
import 'package:starterkit_app/common/localization/generated/l10n.dart';

Future<Il8n> setupLocale([String langCode = 'en']) {
  return Il8n.load(Locale(langCode));
}

String readFileAsString(String fileName) {
  final File file = File(join('test', 'assets', fileName));

  if (file.existsSync()) {
    final String text = file.readAsStringSync();

    return text;
  }

  throw Exception('File not found: ${file.uri}}');
}
