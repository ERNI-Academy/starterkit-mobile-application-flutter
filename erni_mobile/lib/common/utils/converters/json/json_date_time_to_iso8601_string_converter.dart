import 'package:json_annotation/json_annotation.dart';

class JsonDateTimeToIso8601StringConverter implements JsonConverter<DateTime, String> {
  const JsonDateTimeToIso8601StringConverter();

  @override
  DateTime fromJson(String json) => DateTime.parse(json);

  @override
  String toJson(DateTime json) => json.toIso8601String();
}
