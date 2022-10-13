import 'dart:async';

import 'package:erni_mobile/business/models/settings/settings_changed_model.dart';
import 'package:erni_mobile/domain/models/json/json_encodable_mixin.dart';
import 'package:erni_mobile/domain/services/json/json_converter.dart';

abstract class SettingsService {
  Stream<SettingsChangedModel> get settingsChanged;

  T? getValue<T extends Object>(String key, {T? defaultValue});

  T? getObject<T extends JsonEncodableMixin>(String key, JsonConverterCallback<T> converter, {T? defaultValue});

  Future<void> addOrUpdateValue(String key, Object value);

  Future<void> addOrUpdateObject(String key, JsonEncodableMixin value);

  Future<void> delete(String key);

  Future<void> deleteAll();

  void dispose();
}
