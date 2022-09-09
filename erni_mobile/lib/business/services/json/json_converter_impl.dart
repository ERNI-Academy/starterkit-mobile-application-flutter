// coverage:ignore-file

import 'dart:convert';

import 'package:erni_mobile/domain/services/json/json_converter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: JsonConverter)
class JsonConverterImpl implements JsonConverter {
  @override
  T? decodeToObject<T extends Object>(
    String decodable, {
    required JsonConverterCallback<T> converter,
    T? Function(Object error)? onConversionFailed,
  }) {
    assert(decodable.isNotEmpty);

    try {
      final json = jsonDecode(decodable) as Object;

      if (json is List<Map>) {
        throw FormatException('The decoded JSON is a List, use `decodeToList` instead', json);
      } else if (json is Map<String, dynamic>) {
        return converter(json);
      } else {
        return json as T?;
      }
    } on FormatException catch (e, st) {
      if (onConversionFailed != null) {
        return onConversionFailed(e);
      }

      Error.throwWithStackTrace(FormatException('Cannot decode String to JSON', decodable), st);
    }
  }

  @override
  List<T> decodeToList<T extends Object>(
    String decodable, {
    JsonConverterCallback<T>? itemConverter,
    List<T> Function(Object error)? onConversionFailed,
  }) {
    assert(decodable.isNotEmpty);

    try {
      final json = jsonDecode(decodable) as Object;

      if (json is List<Map> && itemConverter != null) {
        return json.map<T>((e) => itemConverter(e.cast<String, Object>())!).toList();
      } else if (json is List<T>) {
        return json;
      } else {
        throw FormatException('The decoded JSON is not a List, use `decodeToObject` instead', json);
      }
    } on FormatException catch (e, st) {
      if (onConversionFailed != null) {
        return onConversionFailed(e);
      }

      Error.throwWithStackTrace(FormatException('Cannot decode String to JSON', decodable), st);
    }
  }

  @override
  Object decode(String encodable) => jsonDecode(encodable) as Object;

  @override
  String encode(Object encodable) => jsonEncode(encodable);
}
