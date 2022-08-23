import 'dart:convert';

import 'package:drift/drift.dart';

class DatabaseMapToStringConverter implements TypeConverter<Map<String, Object>, String> {
  const DatabaseMapToStringConverter();

  @override
  Map<String, Object>? mapToDart(String? fromDb) {
    if (fromDb == null) {
      return null;
    }

    return (jsonDecode(fromDb) as Map).cast();
  }

  @override
  String? mapToSql(Map<String, Object>? value) {
    if (value == null) {
      return null;
    }

    return jsonEncode(value);
  }
}
