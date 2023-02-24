import 'package:erni_mobile/business/models/hive_type_ids.dart';
import 'package:hive/hive.dart';

part 'log_level.g.dart';

@HiveType(typeId: HiveTypeIds.logLevel)
enum LogLevel {
  @HiveField(0)
  off(0),

  @HiveField(1)
  debug(100),

  @HiveField(2)
  info(200),

  @HiveField(3)
  warning(300),

  @HiveField(4)
  error(400);

  const LogLevel(this.value);

  final int value;
}
