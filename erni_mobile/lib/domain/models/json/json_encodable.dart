import 'dart:convert';

export 'package:json_annotation/json_annotation.dart' show JsonSerializable;

abstract class JsonEncodable {
  static const encoder = JsonEncoder.withIndent('    ');

  const JsonEncodable();

  @override
  String toString() => encoder.convert(this);

  Map<String, dynamic> toJson();
}
