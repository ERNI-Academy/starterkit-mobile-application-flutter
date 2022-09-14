import 'dart:convert';

import 'package:drift/drift.dart';

class DatabaseMapToStringConverter implements TypeConverter<Map<String, Object>, String> {
  const DatabaseMapToStringConverter();

  @override
  Map<String, Object> fromSql(String fromDb) => (jsonDecode(fromDb) as Map).cast();

  @override
  String toSql(Map<String, Object> value) => jsonEncode(value);
}
