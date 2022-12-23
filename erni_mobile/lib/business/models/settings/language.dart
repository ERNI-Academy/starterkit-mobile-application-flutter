import 'dart:ui';

import 'package:erni_mobile/business/models/settings/language_code.dart';
import 'package:erni_mobile/common/utils/converters/json/json_language_code_to_string_converter.dart';
import 'package:erni_mobile/domain/models/json/json_encodable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'language.g.dart';

@JsonSerializable()
@JsonLanguageCodeToStringConverter()
class Language extends JsonEncodable {
  const Language(this.languageCode, [this.countryCode]);

  factory Language.fromJson(Map<String, dynamic> json) => _$LanguageFromJson(json);

  final LanguageCode languageCode;
  final String? countryCode;

  @override
  Map<String, dynamic> toJson() => _$LanguageToJson(this);

  Locale toLocale() => Locale(languageCode.name, countryCode);
}
