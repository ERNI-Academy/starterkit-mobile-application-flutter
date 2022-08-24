import 'dart:async';

import 'package:erni_mobile/business/models/settings/settings_changed_model.dart';
import 'package:erni_mobile_core/json.dart';

abstract class SettingsService {
  Stream<SettingsChangedModel> get settingsChanged;

  T? getValue<T extends Object>(String key, {T? defaultValue});

  T? getObject<T extends JsonEncodable>(String key, JsonConverterCallback<T> converter, {T? defaultValue});

  Future<void> addOrUpdateValue(String key, Object value);

  Future<void> addOrUpdateObject(String key, JsonEncodable value);

  Future<void> delete(String key);

  Future<void> deleteAll();

  void dispose();
}
