import 'package:erni_mobile/business/models/logging/log_level.dart';
import 'package:erni_mobile/common/utils/converters/converter.dart';

class LogLevelToStringConverter implements Converter<LogLevel, String> {
  const LogLevelToStringConverter();

  @override
  LogLevel convert(String value) => LogLevel.values.byName(value);

  @override
  String convertBack(LogLevel value) => value.name;
}
