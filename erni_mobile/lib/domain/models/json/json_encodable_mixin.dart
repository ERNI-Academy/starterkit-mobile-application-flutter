// coverage:ignore-file

import 'dart:convert';

export 'package:json_annotation/json_annotation.dart' show JsonSerializable;

mixin JsonEncodableMixin {
  static const _encoder = JsonEncoder.withIndent('    ');

  @override
  String toString() => _encoder.convert(this);

  Map<String, dynamic> toJson();
}
