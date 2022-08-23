abstract class SecureSettingsService {
  Future<void> addOrUpdateValue(String key, String value);

  Future<String?> getValue(String key, {String? defaultValue});

  Future<void> delete(String key);

  Future<void> deleteAll();
}
