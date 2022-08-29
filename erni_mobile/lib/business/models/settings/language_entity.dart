import 'dart:ui';

import 'package:erni_mobile/business/models/settings/language_code.dart';
import 'package:erni_mobile/common/utils/converters/json/json_language_code_to_string_converter.dart';
import 'package:erni_mobile/domain/models/json/codable_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'language_entity.g.dart';

@JsonSerializable()
@JsonLanguageCodeToStringConverter()
class LanguageEntity extends CodableEntity {
  const LanguageEntity(this.languageCode, [this.countryCode]);

  factory LanguageEntity.fromJson(Map<String, dynamic> json) => _$LanguageEntityFromJson(json);

  final LanguageCode languageCode;
  final String? countryCode;

  @override
  Map<String, dynamic> toJson() => _$LanguageEntityToJson(this);

  Locale toLocale() => Locale(languageCode.name, countryCode);
}
