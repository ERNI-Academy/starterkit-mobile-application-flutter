// coverage:ignore-file

import 'package:drift/drift.dart';
import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/common/utils/converters/log_level_to_string_converter.dart';

class DatabaseLogLevelToStringConverter extends LogLevelToStringConverter implements TypeConverter<LogLevel, String> {
  const DatabaseLogLevelToStringConverter();

  @override
  LogLevel? mapToDart(String? fromDb) => convert(fromDb!);

  @override
  String? mapToSql(LogLevel? value) => convertBack(value!);
}
