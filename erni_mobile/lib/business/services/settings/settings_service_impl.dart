import 'dart:async';

import 'package:erni_mobile/business/models/settings/settings_changed.dart';
import 'package:erni_mobile/domain/models/json/json_encodable_mixin.dart';
import 'package:erni_mobile/domain/services/json/json_converter.dart' as json_converter;
import 'package:erni_mobile/domain/services/settings/settings_service.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: SettingsService)
class SettingsServiceImpl implements SettingsService {
  final StreamController<SettingsChanged> _streamController = StreamController.broadcast();
  final json_converter.JsonConverter _jsonConverter;
  final SharedPreferences _prefs;

  SettingsServiceImpl(this._prefs, this._jsonConverter) {
    settingsChanged = _streamController.stream;
  }

  @override
  late final Stream<SettingsChanged> settingsChanged;

  @override
  T? getValue<T extends Object>(String key, {T? defaultValue}) {
    final value = _prefs.get(key);

    return value as T? ?? defaultValue;
  }

  @override
  T? getObject<T extends JsonEncodableMixin>(
    String key,
    json_converter.JsonConverterCallback<T> converter, {
    T? defaultValue,
  }) {
    final value = _prefs.get(key) as String?;

    if (value != null) {
      return _jsonConverter.decodeToObject<T>(value, converter: converter);
    }

    return defaultValue;
  }

  @override
  Iterable<T> getObjects<T extends JsonEncodableMixin>(
    String key,
    json_converter.JsonConverterCallback<T> converter, {
    Iterable<T> defaultValues = const [],
  }) {
    final values = _prefs.getString(key);

    if (values != null) {
      return _jsonConverter.decodeToCollection<T>(values, itemConverter: converter);
    }

    return defaultValues;
  }

  @override
  Future<bool> addOrUpdateValue(String key, Object value) async {
    final didUpdate = await _tryAddOrUpdateValue(key, value);

    if (didUpdate && !_streamController.isClosed) {
      _streamController.add(SettingsChanged(key, value));
    }

    return didUpdate;
  }

  @override
  Future<bool> addOrUpdateObject(String key, JsonEncodableMixin value) async {
    final encoded = _jsonConverter.encode(value);
    final didUpdate = await _tryAddOrUpdateValue(key, encoded);

    if (didUpdate && !_streamController.isClosed) {
      _streamController.add(SettingsChanged(key, value));
    }

    return didUpdate;
  }

  @override
  Future<void> addOrUpdateObjects(String key, Iterable<JsonEncodableMixin> values) async {
    final encoded = _jsonConverter.encode(values);
    final didUpdate = await _tryAddOrUpdateValue(key, encoded);

    if (didUpdate && !_streamController.isClosed) {
      _streamController.add(SettingsChanged(key, values));
    }
  }

  @override
  Future<void> delete(String key) async {
    final didUpdate = await _prefs.remove(key);

    if (didUpdate && !_streamController.isClosed) {
      _streamController.add(SettingsChanged(key, null));
    }
  }

  @override
  Future<void> deleteAll() async {
    await _prefs.clear();
  }

  @disposeMethod
  @override
  void dispose() {
    _streamController.close();
  }

  Future<bool> _tryAddOrUpdateValue(String key, Object value) async {
    var didUpdate = false;

    if (value is String) {
      didUpdate = await _prefs.setString(key, value);
    } else if (value is int) {
      didUpdate = await _prefs.setInt(key, value);
    } else if (value is double) {
      didUpdate = await _prefs.setDouble(key, value);
    } else if (value is bool) {
      didUpdate = await _prefs.setBool(key, value);
    } else {
      throw UnsupportedError('${value.runtimeType} not supported');
    }

    return didUpdate;
  }
}
