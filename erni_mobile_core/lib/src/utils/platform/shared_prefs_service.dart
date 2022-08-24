import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPrefsService {
  Future<bool> clear(String key);

  Future<bool> clearAll();

  T? getValue<T>(String key);

  Future<bool> setValue(String key, Object value);
}

@Singleton(as: SharedPrefsService)
@preResolve
@prod
class SharedPrefsServiceImpl implements SharedPrefsService {
  SharedPrefsServiceImpl(this.prefs);

  final SharedPreferences prefs;

  @factoryMethod
  static Future<SharedPrefsService> create() async {
    final prefs = await SharedPreferences.getInstance();

    return SharedPrefsServiceImpl(prefs);
  }

  @override
  Future<bool> clear(String key) async {
    assert(key.isNotEmpty);

    return prefs.remove(key);
  }

  @override
  Future<bool> clearAll() => prefs.clear();

  @override
  T? getValue<T>(String key) {
    assert(key.isNotEmpty);

    final value = prefs.get(key);

    return value as T?;
  }

  @override
  Future<bool> setValue(String key, Object value) async {
    assert(key.isNotEmpty);

    if (value is String) {
      return prefs.setString(key, value);
    } else if (value is int) {
      return prefs.setInt(key, value);
    } else if (value is double) {
      return prefs.setDouble(key, value);
    } else if (value is bool) {
      return prefs.setBool(key, value);
    } else {
      throw UnsupportedError('${value.runtimeType} not supported');
    }
  }
}

@LazySingleton(as: SharedPrefsService)
@test
class TestSharedPrefsServiceImpl implements SharedPrefsService {
  @override
  Future<bool> clear(String key) => Future.value(false);

  @override
  Future<bool> clearAll() => Future.value(false);

  @override
  T? getValue<T>(String key) => null;

  @override
  Future<bool> setValue(String key, Object value) async => Future.value(false);
}
