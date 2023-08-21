// coverage:ignore-file

import 'dart:convert';

import 'package:meta/meta.dart';

export 'package:json_annotation/json_annotation.dart';

@immutable
abstract class JsonSerializableObject {
  static const JsonEncoder _encoder = JsonEncoder.withIndent('    ');

  const JsonSerializableObject();

  @override
  String toString() => _encoder.convert(this);

  Map<String, dynamic> toJson();
}
