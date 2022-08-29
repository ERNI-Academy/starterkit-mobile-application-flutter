import 'dart:async';

import 'package:erni_mobile/business/models/settings/settings_changed_model.dart';
import 'package:erni_mobile/domain/models/json/json_encodable.dart';
import 'package:erni_mobile/domain/services/json/json_service.dart';
import 'package:erni_mobile/domain/services/settings/settings_service.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: SettingsService)
@preResolve
class SettingsServiceImpl implements SettingsService {
  SettingsServiceImpl(this._prefs, this._jsonService) {
    settingsChanged = _streamController.stream;
  }

  final StreamController<SettingsChangedModel> _streamController = StreamController.broadcast();
  final JsonService _jsonService;
  final SharedPreferences _prefs;

  @override
  late final Stream<SettingsChangedModel> settingsChanged;

  @factoryMethod
  static Future<SettingsServiceImpl> create(JsonService jsonService) async {
    final prefs = await SharedPreferences.getInstance();

    return SettingsServiceImpl(prefs, jsonService);
  }

  @override
  T? getValue<T extends Object>(String key, {T? defaultValue}) {
    final value = _prefs.get(key);

    return value as T? ?? defaultValue;
  }

  @override
  T? getObject<T extends JsonEncodable>(String key, JsonConverterCallback<T> converter, {T? defaultValue}) {
    final value = _prefs.get(key) as String?;

    if (value != null) {
      return _jsonService.decodeToObject<T>(value, converter: converter);
    }

    return defaultValue;
  }

  @override
  Future<bool> addOrUpdateValue(String key, Object value) async {
    final didUpdate = await _tryAddOrUpdateValue(key, value);

    if (didUpdate && !_streamController.isClosed) {
      _streamController.add(SettingsChangedModel(key, value));
    }

    return didUpdate;
  }

  @override
  Future<bool> addOrUpdateObject(String key, JsonEncodable value) async {
    final encoded = _jsonService.encode(value);
    final didUpdate = await _tryAddOrUpdateValue(key, encoded);

    if (didUpdate && !_streamController.isClosed) {
      _streamController.add(SettingsChangedModel(key, value));
    }

    return didUpdate;
  }

  @override
  Future<void> delete(String key) async {
    final didUpdate = await _prefs.remove(key);

    if (didUpdate && !_streamController.isClosed) {
      _streamController.add(SettingsChangedModel(key, null));
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
