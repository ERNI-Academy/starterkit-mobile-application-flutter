import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

abstract class SecureStorageService {
  Future<void> add(String key, String value);

  Future<void> clear(String key);

  Future<void> clearAll();

  Future<String?> getValue(String key);
}

@LazySingleton(as: SecureStorageService)
@prod
class SecureStorageServiceImpl implements SecureStorageService {
  SecureStorageServiceImpl(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  @factoryMethod
  static SecureStorageService create() {
    const secureStorage = FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );

    return SecureStorageServiceImpl(secureStorage);
  }

  @override
  Future<void> add(String key, String value) {
    assert(key.isNotEmpty);
    assert(value.isNotEmpty);

    return _secureStorage.write(key: key, value: value);
  }

  @override
  Future<void> clear(String key) {
    assert(key.isNotEmpty);

    return _secureStorage.delete(key: key);
  }

  @override
  Future<void> clearAll() => _secureStorage.deleteAll();

  @override
  Future<String?> getValue(String key) {
    assert(key.isNotEmpty);

    return _secureStorage.read(key: key);
  }
}

@Singleton(as: SecureStorageService)
@test
class TestSecureStorageServiceImpl implements SecureStorageService {
  @override
  Future<void> add(String key, String value) => Future.value();

  @override
  Future<void> clear(String key) => Future.value();

  @override
  Future<void> clearAll() => Future.value();

  @override
  Future<String?> getValue(String key) => Future.value();
}
