import 'package:erni_mobile/domain/services/settings/secure_settings_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SecureSettingsService)
class SecureSettingsServiceImpl implements SecureSettingsService {
  final FlutterSecureStorage _secureStorage;

  SecureSettingsServiceImpl(this._secureStorage);

  @override
  Future<void> addOrUpdateValue(String key, String value) {
    return _secureStorage.write(key: key, value: value);
  }

  @override
  Future<String?> getValue(String key, {String? defaultValue}) async {
    final value = await _secureStorage.read(key: key);

    return value ?? defaultValue;
  }

  @override
  Future<void> delete(String key) => _secureStorage.delete(key: key);

  @override
  Future<void> deleteAll() => _secureStorage.deleteAll();
}
