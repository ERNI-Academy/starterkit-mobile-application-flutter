import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class JsonThemeModeToStringConverter implements JsonConverter<ThemeMode, String> {
  const JsonThemeModeToStringConverter();

  @override
  ThemeMode fromJson(String theme) => ThemeMode.values.byName(theme);

  @override
  String toJson(ThemeMode theme) => theme.name;
}
