import 'package:erni_mobile/business/models/settings/language.dart';
import 'package:erni_mobile/business/models/settings/language_code.dart';
import 'package:erni_mobile/common/utils/converters/json/json_theme_mode_to_string_converter.dart';
import 'package:erni_mobile/domain/models/json/json_encodable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_settings.g.dart';

@JsonSerializable(explicitToJson: true)
@JsonThemeModeToStringConverter()
class AppSettings extends JsonEncodable {
  const AppSettings([
    this.language = const Language(LanguageCode.en),
    this.themeMode = ThemeMode.light,
  ]);

  factory AppSettings.fromJson(Map<String, dynamic> json) => _$AppSettingsFromJson(json);

  final Language language;
  final ThemeMode themeMode;

  @override
  Map<String, dynamic> toJson() => _$AppSettingsToJson(this);
}
