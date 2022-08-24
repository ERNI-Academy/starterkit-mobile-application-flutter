// coverage:ignore-file

import 'package:drift/drift.dart';
import 'package:erni_mobile/data/database/logging/converters/database_log_level_to_string_converter.dart';
import 'package:erni_mobile/data/database/logging/converters/database_map_to_string_converter.dart';
import 'package:erni_mobile_core/data.dart';

@DataClassName('AppLogObject')
class AppLogs extends DataTable {
  @override
  TextColumn get id => text()();

  TextColumn get sessionId => text()();

  TextColumn get owner => text()();

  TextColumn get level => text().map(const DatabaseLogLevelToStringConverter())();

  TextColumn get message => text()();

  DateTimeColumn get createdAt => dateTime()();

  TextColumn get extras => text().map(const DatabaseMapToStringConverter())();
}
