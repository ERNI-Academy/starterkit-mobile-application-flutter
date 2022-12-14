import 'package:erni_mobile/business/models/settings/language_code.dart';
import 'package:erni_mobile/business/models/settings/language_entity.dart';
import 'package:erni_mobile/common/utils/converters/json/json_theme_mode_to_string_converter.dart';
import 'package:erni_mobile/domain/models/json/json_encodable_entity.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_settings_entity.g.dart';

@JsonSerializable(explicitToJson: true)
@JsonThemeModeToStringConverter()
class AppSettingsEntity extends JsonEncodableEntity {
  const AppSettingsEntity([
    this.language = const LanguageEntity(LanguageCode.en),
    this.themeMode = ThemeMode.light,
  ]);

  factory AppSettingsEntity.fromJson(Map<String, dynamic> json) => _$AppSettingsEntityFromJson(json);

  final LanguageEntity language;
  final ThemeMode themeMode;

  @override
  Map<String, dynamic> toJson() => _$AppSettingsEntityToJson(this);
}
