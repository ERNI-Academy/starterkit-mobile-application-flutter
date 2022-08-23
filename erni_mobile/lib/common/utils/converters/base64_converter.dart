import 'dart:convert';

import 'package:erni_mobile/common/utils/converters/converter.dart';

class Base64Converter implements Converter<String, String> {
  static final Codec<String, String> _stringToBase64 = utf8.fuse(base64);

  const Base64Converter();

  @override
  String convert(String encoded) => _stringToBase64.decode(encoded);

  @override
  String convertBack(String decoded) => _stringToBase64.encode(decoded);
}
