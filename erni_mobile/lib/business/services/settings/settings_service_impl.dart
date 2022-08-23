import 'dart:async';

import 'package:erni_mobile/business/models/settings/settings_changed_model.dart';
import 'package:erni_mobile/domain/services/settings/settings_service.dart';
import 'package:erni_mobile_blueprint_core/json.dart';
import 'package:erni_mobile_blueprint_core/utils.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SettingsService)
class SettingsServiceImpl implements SettingsService {
  SettingsServiceImpl(this._prefs, this._jsonConverter) {
    settingsChanged = _streamController.stream;
  }

  final StreamController<SettingsChangedModel> _streamController = StreamController.broadcast();
  final JsonConverter _jsonConverter;
  final SharedPrefsService _prefs;

  @override
  late final Stream<SettingsChangedModel> settingsChanged;

  @override
  T? getValue<T extends Object>(String key, {T? defaultValue}) {
    assert(key.isNotEmpty);

    final value = _prefs.getValue<T>(key);

    return value ?? defaultValue;
  }

  @override
  T? getObject<T extends JsonEncodable>(String key, JsonConverterCallback<T> converter, {T? defaultValue}) {
    assert(key.isNotEmpty);

    final value = _prefs.getValue<String>(key);

    if (value != null) {
      return _jsonConverter.decodeToObject<T>(value, converter: converter);
    }

    return defaultValue;
  }

  @override
  Future<void> addOrUpdateValue(String key, Object value) async {
    assert(key.isNotEmpty);

    final didUpdate = await _prefs.setValue(key, value);

    if (didUpdate && !_streamController.isClosed) {
      _streamController.add(SettingsChangedModel(key, value));
    }
  }

  @override
  Future<void> addOrUpdateObject(String key, JsonEncodable value) async {
    assert(key.isNotEmpty);

    final encoded = _jsonConverter.encode(value);
    final didUpdate = await _prefs.setValue(key, encoded);

    if (didUpdate && !_streamController.isClosed) {
      _streamController.add(SettingsChangedModel(key, value));
    }
  }

  @override
  Future<void> delete(String key) async {
    assert(key.isNotEmpty);

    final didUpdate = await _prefs.clear(key);

    if (didUpdate && !_streamController.isClosed) {
      _streamController.add(SettingsChangedModel(key, null));
    }
  }

  @override
  Future<void> deleteAll() async {
    await _prefs.clearAll();
  }

  @disposeMethod
  @override
  void dispose() {
    _streamController.close();
  }
}
