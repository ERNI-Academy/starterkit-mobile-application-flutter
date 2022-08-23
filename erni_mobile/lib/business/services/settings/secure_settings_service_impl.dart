import 'package:erni_mobile/domain/services/settings/secure_settings_service.dart';
import 'package:erni_mobile_blueprint_core/utils.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SecureSettingsService)
class SecureSettingsServiceImpl implements SecureSettingsService {
  SecureSettingsServiceImpl(this._secureStorageService);

  final SecureStorageService _secureStorageService;

  @override
  Future<void> addOrUpdateValue(String key, String value) async {
    await _secureStorageService.add(key, value);
  }

  @override
  Future<String?> getValue(String key, {String? defaultValue}) async {
    final value = await _secureStorageService.getValue(key);

    return value ?? defaultValue;
  }

  @override
  Future<void> delete(String key) => _secureStorageService.clear(key);

  @override
  Future<void> deleteAll() => _secureStorageService.clearAll();
}
