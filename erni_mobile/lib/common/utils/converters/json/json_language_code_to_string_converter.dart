import 'package:erni_mobile/business/models/settings/language_code.dart';
import 'package:json_annotation/json_annotation.dart';

class JsonLanguageCodeToStringConverter implements JsonConverter<LanguageCode, String> {
  const JsonLanguageCodeToStringConverter();

  @override
  LanguageCode fromJson(String json) => LanguageCode.values.byName(json);

  @override
  String toJson(LanguageCode object) => object.name;
}
